pragma circom 2.0.0;

include "../node_modules/circomlib/circuits/poseidon.circom";
include "../node_modules/circomlib/circuits/mux1.circom";
template CheckRoot(n) { // compute the root of a MerkleTree of n Levels 
    signal input leaves[2**n];
    signal output root;

    var intermediateHashes=((2**n)/2) -1;    //amount of intermediate hashing that needs to be done
    var leafHashes=((2**n)/2);//total number of leaf hashing
    var numHashers=(2**n)-1;//total number of hashing done
    component hasher[numHashers];
    //[assignment] insert your code here to calculate the Merkle root from 2^n leaves
    // initiate all hashers
    for(var i=0;i<numHashers;i++){
        hasher[i]=Poseidon(2);
    }

    //hash the leaf nodes
    for(var i=0;i<leafHashes;i++){
        hasher[i].inputs[0]<==leaves[i*2];
        hasher[i].inputs[1]<==leaves[i*2 +1];
    }
    for(var i=leafHashes;i<leafHashes+intermediateHashes;i++){
        hasher[i].inputs[0]<==hasher[(i-leafHashes)*2].out;
        hasher[i].inputs[1]<==hasher[((i-leafHashes)*2) + 1].out;
    }

    root<==hasher[numHashers-1].out;
   
}

template MerkleTreeInclusionProof(n) {
    signal input leaf;
    signal input path_elements[n];
    signal input path_index[n]; // path index are 0's and 1's indicating whether the current element is on the left or right
    signal output root; // note that this is an OUTPUT signal

    //[assignment] insert your code here to compute the root from a leaf and elements along the path
    signal hashes[n+1];
    hashes[0]<==leaf;
    component hashers[n];
    component mux[n];
    for(var i=0;i<n;i++){
        hashers[i]=Poseidon(2);
        mux[i]=MultiMux1(2);
        //initializeing the multiplexer and poseidon hasher component
        mux[i].c[0][0]<==hashes[i];
        mux[i].c[0][1]<==path_elements[i];
        mux[i].c[1][0]<==path_elements[i];
        mux[i].c[1][1]<==hashes[i];
        mux[i].s<==path_index[i];//multiplexer selecctor signal (to use as if else)
        
        hashers[i].inputs[0]<==mux[i].out[0];
        hashers[i].inputs[1]<==mux[i].out[1];
        hashes[i+1]<==hashers[i].out;
    }
    root<==hashes[n];

}