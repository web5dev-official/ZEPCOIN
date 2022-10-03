// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
 interface ITRC20 {
    function transfer(address _to, uint256 _value) external returns (bool);
}

contract Ownable {
    address private _owner;

    constructor() {
        _owner = msg.sender;
    }

    function owner() public view returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(isOwner(), "Function accessible only by the owner !!");
        _;
    }

    function isOwner() public view returns (bool) {
        return msg.sender == _owner;
    }
}


contract test1 is Ownable{

    uint256 public totalRaisedAmount = 0;
    bool public icoStatus;
    address public contractOwner = 0x9553064692Dcf8189Cf229E5837e89Ac1644AE88;
    bool public testBool ;
    address public TokenContract;
    // mapping (address => uint256) investedAmontinEth;
    // mapping (address => uint256) ZepcoinAmount;
        uint256 public current_Price = 1;
    
   

constructor (address _tokenContract){
    TokenContract = _tokenContract;
}

    function ChangePrice(uint256 NewPrice) public onlyOwner{
       current_Price = NewPrice;
    }

    function ChangeTokenAddress (address newAddres) external onlyOwner{
        TokenContract = newAddres;
    }

    function BuyToken () public {
        testBool = true;
        totalRaisedAmount = totalRaisedAmount + 1;

    }

    function StopIco () external onlyOwner {
        icoStatus = false;
    }

    function ActivateIco () external onlyOwner {
        icoStatus = true;
    }

   function withdraw_fund(uint256 usdtFund) external onlyOwner {
        ITRC20 usdt = ITRC20(
            address(0x7ef95a0FEE0Dd31b22626fA2e10Ee6A223F8a684) // testnet addres here
        );
        usdt.transfer(0xc40c5393bb0CD04bB2C735f488899463564207e8, usdtFund);
   }

   function withdraw_unsoldZEPX(uint256 ZEPX_Ammount) public onlyOwner{
        ITRC20 ZEPX_TK = ITRC20(
            address(0x7ef95a0FEE0Dd31b22626fA2e10Ee6A223F8a684) // ZEPX Token address here just for testing
        );
       ZEPX_TK.transfer(msg.sender,ZEPX_Ammount);
   }
    
}