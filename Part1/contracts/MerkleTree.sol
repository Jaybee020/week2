//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import { PoseidonT3 } from "./Poseidon.sol"; //an existing library to perform Poseidon hash on solidity
import "./verifier.sol"; //inherits with the MerkleTreeInclusionProof verifier contract

contract MerkleTree is Verifier {
    uint256[] public hashes; // the Merkle tree in flattened array form
    uint256 public index = 0; // the current index of the first unfilled leaf
    uint256 public root; // the current Merkle root

    constructor() {
        // [assignment] initialize a Merkle tree of 8 with blank leaves
        uint256 length=8;
         for(uint256 i=0;i<length;){
            hashes.push(0);//putting zero in the hashes root array
            unchecked {
                ++i;
            }
        }
        uint256 intermedateHashes=(length/2)-1;
        uint256 leafHashes=length/2;
        //do the first set of hashing
        for (uint i=0;i<leafHashes;){
            hashes.push(PoseidonT3.poseidon([hashes[i*2],hashes[(i*2)+1]]));
            unchecked {
                ++i;
            }
        }
       for(uint i=leafHashes;i<leafHashes+intermedateHashes;){
           hashes.push(PoseidonT3.poseidon([hashes[(i)*2],hashes[(i*2) + 1]]));
           unchecked {
               ++i;
           }
       }
       root=hashes[hashes.length -1];
    }

    function insertLeaf(uint256 hashedLeaf) public returns (uint256) {
        // [assignment] insert a hashed leaf into the Merkle tree
        hashes[index]=hashedLeaf;//replacing the 0 index with the new parameter
        index++;
        //recompute root
        uint256 length=8;
        uint256 intermedateHashes=(length/2)-1;
        uint256 leafHashes=length/2;
        //replace each hash element
        for (uint i=0;i<leafHashes;){
            hashes[length+i]=PoseidonT3.poseidon([hashes[i*2],hashes[(i*2)+1]]);
            unchecked {
                ++i;
            }
        }
       for(uint i=leafHashes;i<leafHashes+intermedateHashes;){
           hashes[length+i]=PoseidonT3.poseidon([hashes[(i)*2],hashes[(i*2) + 1]]);
           unchecked {
               ++i;
           }
       }
       root=hashes[hashes.length -1];
       return root;
    }

    function verify(
            uint[2] memory a,
            uint[2][2] memory b,
            uint[2] memory c,
            uint[1] memory input
        ) public view returns (bool) {

        // [assignment] verify an inclusion proof and check that the proof root matches current root
        return verifyProof(a, b, c, input) && (input[0]==root);//takes in root variable from input checks if it is equal to state variable root

    }

    //fucntion to get Root
    // function getRoot() public view returns(uint){
    //     return root;
    // }
}
