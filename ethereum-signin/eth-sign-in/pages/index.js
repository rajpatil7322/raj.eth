import Head from "next/head";
import styles from "../styles/Home.module.css";

import { providers, Contract,utils } from "ethers";
import { useEffect, useRef, useState } from "react";
import { recoverAddress } from "ethers/lib/utils";


export default function Home() {
  const { MerkleTree } = require('merkletreejs')
  const SHA256 = require('crypto-js/sha256')


  // const leaves = ['a'].map(x => SHA256(x))
  // const tree = new MerkleTree(leaves, SHA256)
  // const root = tree.getRoot().toString('hex')
  // console.log(root);
  // const leaf = SHA256('0x11E2f924c2C0aB9eb4d62dAf027A71A96c4fCB1C')
  // const proof = tree.getProof(leaf)
  // console.log(tree.verify(proof, leaf, root)) // true

  

  // const[account,setAccount]=useState('');
  const account=useRef('');
  const[signer,setSigner]=useState('');
  const leaves=['a'];
  const[authenticated,setAuth]=useState(false);
  const[root,setRoot]=useState('');
  const[tree,setTree]=useState('');

  async function constructRoot(add){
    leaves.push(add);
    console.log(leaves);
    const hashedleaves = leaves.map(x => SHA256(x))
    const tree = new MerkleTree(hashedleaves, SHA256)
    const root = tree.getRoot().toString('hex')
    console.log(root);
    console.log(leaves.length);
  }
  
  

  const connectwallet=async()=>{
    const provider = new providers.Web3Provider(window.ethereum, "any");
    if (provider){
      await provider.send("eth_requestAccounts", []);
      const signer = provider.getSigner();
      setSigner(signer);
      // setAccount(await signer.getAddress())
      account.current=await signer.getAddress();
     
      const leaf = SHA256(account.current);
      const tree = new MerkleTree(leaves, SHA256)
      const proof = tree.getProof(leaf)
      
      if (tree.verify(proof, leaf, root)){
        authenticated(true);
        console.log("address is in tree");
      }else{
        window.alert("please Sign up")
      }

      console.log("Account:", await signer.getAddress());
    }
  }

  async function signIn(){
    try{
      let msg="Hii sucker";
      const signature=await signer.signMessage(msg);

      console.log(signature);
    }catch(err){
      window.alert(err)
    }
    
  }

  async function signup(){
    try{
      constructRoot(account.current);
    }catch(err){
      window.alert(err);
    }
  }


  useEffect(() => {
    async function listenMMAccount() {
      window.ethereum.on("accountsChanged", async function() {
        const provider = new providers.Web3Provider(window.ethereum, "any");
        await provider.send("eth_requestAccounts", []);
        const signer = provider.getSigner();
        setSigner(signer);
        setAccount(await signer.getAddress())
      });

    }
    listenMMAccount();
  }, []);

 

  return (
    <div>
      <h1>
        Helloo !!!
      </h1>
      <button onClick={connectwallet}>
        Connect Wallet
      </button>
      <button onClick={signup}>
        Sign Up
      </button>
    </div>
  )
}