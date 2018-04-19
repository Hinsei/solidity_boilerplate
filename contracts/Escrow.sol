pragma solidity ^0.4.2;

contract Escrow {

  enum EscrowState {
    PENDING,
    FULLY_DEPOSITED,
    TRANSFERED,
    REFUNDED
  }

  address public employer;
  address public employee;

  uint8 public amount;

  mapping (address => bool) public approvals;

  EscrowState public status;

  event fundsTransfered();
  event fundsRefunded();

  function Escrow(address _employer, address _employee, uint8 _amount) public {
    employer = _employer;
    employee = _employee;
    amount = _amount;
    status = EscrowState.PENDING;
    deposit();
  }

  function approve() public {
    require(status == EscrowState.FULLY_DEPOSITED);
    approvals[msg.sender] = true;
    initiateFundsRelease();
  } 

  function initiateFundsRelease () private {
    if(approvals[employer] && approvals[employee]) {
      employee.transfer(amount);
      emit fundsTransfered();
    }
  }

  function deposit () public payable {
    if (address(this).balance >= amount){
      status = EscrowState.FULLY_DEPOSITED; 
    }
  }

  function inititateRefund () public payable {
    require(status != EscrowState.FULLY_DEPOSITED || status != EscrowState.TRANSFERED);
    
    status = EscrowState.REFUNDED;
    employer.transfer(address(this).balance);
    emit fundsRefunded();
  }
}
