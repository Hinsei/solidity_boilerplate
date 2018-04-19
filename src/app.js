import {default as Web3} from "web3"
import {default as contract} from "truffle-contract"

window.addEventListener('load', function(){
  if (typeof web3 !== "undefined") {
    console.warn("using web3 detected from external source")
    window.web3 = new Web3(web3.currentProvider)
  } else {
    console.warn("No web3 detected")
    window.web3 = new Web3(new Web3.providers.HttpPorvider("http://localhost:7545"))
  }
})
