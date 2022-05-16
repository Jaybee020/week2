/*
 * ATTENTION: The "eval" devtool has been used (maybe by default in mode: "development").
 * This devtool is neither made for production nor for readable output files.
 * It uses "eval()" calls to create a separate source file in the browser devtools.
 * If you are trying to read the output file, select a different devtool (https://webpack.js.org/configuration/devtool/)
 * or disable the default devtool with "devtool: false".
 * If you are looking for production-ready output files, see mode: "production" (https://webpack.js.org/configuration/mode/).
 */
/******/ (() => { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ({

/***/ "./src/index.ts":
/*!**********************!*\
  !*** ./src/index.ts ***!
  \**********************/
/***/ (function(__unused_webpack_module, exports) {

eval("\nvar __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {\n    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }\n    return new (P || (P = Promise))(function (resolve, reject) {\n        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }\n        function rejected(value) { try { step(generator[\"throw\"](value)); } catch (e) { reject(e); } }\n        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }\n        step((generator = generator.apply(thisArg, _arguments || [])).next());\n    });\n};\nObject.defineProperty(exports, \"__esModule\", ({ value: true }));\n//get eth in the broser\nfunction getEth() {\n    //@ts-ignore\n    const eth = window.ethereum; //ethereum object is added to your window by metamask\n    if (!eth) {\n        throw new Error(\"Could not find metamask\");\n    }\n    return eth;\n}\nconst connectButton = document.getElementById(\"Connect_Metamask\");\n//@ts-ignore\nconnectButton.onclick = run;\n//accounts that are in metamask\nfunction hasAccounts() {\n    return __awaiter(this, void 0, void 0, function* () {\n        const eth = yield getEth();\n        const accounts = yield eth.request({ method: 'eth_accounts' });\n        return accounts && accounts.length;\n    });\n}\n//you request an account from your metamask\nfunction requestAccounts() {\n    return __awaiter(this, void 0, void 0, function* () {\n        const eth = yield getEth();\n        const accounts = yield eth.request({ method: 'eth_requestAccounts' });\n        return accounts && accounts.length;\n    });\n}\nfunction run() {\n    return __awaiter(this, void 0, void 0, function* () {\n        if (!(yield hasAccounts()) && !(yield requestAccounts())) { //asking metamask for accounts in it and requesting the account\n            throw new Error(\"Please install metamask\");\n        }\n        console.log(\"hello\");\n        // const contract=new ethers.Contract(\n        //     \"0xdc64a140aa3e981100a9beca4e685f962f0cf6c9\",//account address youwant to call the contract from\n        //     Counter.abi,//using the contracts abi\n        //     new ethers.providers.Web3Provider(getEth()).getSigner()//web 3 provider api and adding the signer\n        // )\n        // contract.on(contract.filters.counterInc(),function(count){\n        //     setcounter(count)\n        // })\n        // const text=document.createElement(\"div\")\n        // // console.log(\"hello\")\n        // text.style.borderColor=\"red\"\n        // const button=document.createElement(\"button\")\n        // //@ts-ignore\n        // async function setcounter(count?) {\n        //     text.innerHTML=count||await contract.getCounter()//calling the value of counter from the contract\n        // }\n        // setcounter()\n        // button.innerText=\"increment\"\n        // button.onclick=async function(){\n        //     const tx=await contract.count()//calling the contract incrementer function\n        //     await tx.wait()\n        // }\n        // document.body.appendChild(text)\n        // document.body.appendChild(button)\n    });\n}\n\n\n//# sourceURL=webpack://hardhat-project/./src/index.ts?");

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	
/******/ 	// startup
/******/ 	// Load entry module and return exports
/******/ 	// This entry module is referenced by other modules so it can't be inlined
/******/ 	var __webpack_exports__ = {};
/******/ 	__webpack_modules__["./src/index.ts"](0, __webpack_exports__);
/******/ 	
/******/ })()
;