// SPDX-License-Identifier: MIT

 /*---------------.  .----------------.  .----------------.  .----------------.   .----------------.  .----------------.  .----------------. 
| .--------------. || .--------------. || .--------------. || .--------------. | | .--------------. || .--------------. || .--------------. |
| |   ________   | || |  _________   | || |   ______     | || |  ____  ____  | | | |     _____    | || |     ______   | || |     ____     | |
| |  |  __   _|  | || | |_   ___  |  | || |  |_   __ \   | || | |_  _||_  _| | | | |    |_   _|   | || |   .' ___  |  | || |   .'    `.   | |
| |  |_/  / /    | || |   | |_  \_|  | || |    | |__) |  | || |   \ \  / /   | | | |      | |     | || |  / .'   \_|  | || |  /  .--.  \  | |
| |     .'.' _   | || |   |  _|  _   | || |    |  ___/   | || |    > `' <    | | | |      | |     | || |  | |         | || |  | |    | |  | |
| |   _/ /__/ |  | || |  _| |___/ |  | || |   _| |_      | || |  _/ /'`\ \_  | | | |     _| |_    | || |  \ `.___.'\  | || |  \  `--'  /  | |
| |  |________|  | || | |_________|  | || |  |_____|     | || | |____||____| | | | |    |_____|   | || |   `._____.'  | || |   `.____.'   | |
| |              | || |              | || |              | || |              | | | |              | || |              | || |              | |
| '--------------' || '--------------' || '--------------' || '--------------' | | '--------------' || '--------------' || '--------------' |
 '----------------'  '----------------'  '----------------'  '----------------'   '----------------'  '----------------'  '----------------' */

pragma solidity ^0.8.0;

interface IERC20 {
  
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

pragma solidity ^0.8.4;


contract Ownable {
    address private _owner;

    constructor () {
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

contract ZEPCOIN_ICO is Ownable{

    

    
    uint256 public totalRaisedAmount = 0;
    bool public icoStatus;
    address public Admin_Wallet;
    uint256 private current_Price = 10000;
    
   

constructor (address _Admin_Wallet){
    Admin_Wallet = _Admin_Wallet;
}

    function ChangePrice(uint256 NewPrice) external onlyOwner{
       current_Price = NewPrice;
    }


    function BuyToken_usdt (uint256 Usdt_Amount) public  {
        require(!icoStatus,"zepcoin ico is stopped");
        require(Usdt_Amount>=0,"sorry incorect amount");
        IERC20 usdt = IERC20(
            address(0x55d398326f99059fF775485246999027B3197955) // usdt Token address 
        );
        usdt.transferFrom(msg.sender,Admin_Wallet,Usdt_Amount);
        IERC20 ZEPX_TK = IERC20(
            address(0x0Af7aeE626B2641cb1c91c4D42F903D37D88148F) // ZEPX Token address
        );
        ZEPX_TK.transfer(msg.sender,Usdt_Amount*current_Price);
        totalRaisedAmount = totalRaisedAmount + Usdt_Amount;

    }
    
    function BuyToken_busd (uint256 busd_Amount) public {
        require(!icoStatus,"zepcoin ico is stopped");
        require(busd_Amount>=0,"sorry insufficient balance");
        IERC20 Busd = IERC20(
            address(0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56) // busd Token address 
        );

        Busd.transferFrom(msg.sender,Admin_Wallet,busd_Amount);
        IERC20 ZEPX_TK = IERC20(
            address(0x0Af7aeE626B2641cb1c91c4D42F903D37D88148F) // ZEPX Token address 
        );
        ZEPX_TK.transfer(msg.sender,busd_Amount*current_Price);
        totalRaisedAmount = totalRaisedAmount + busd_Amount;

    }

    function StopIco () external onlyOwner {
        icoStatus = true;
    }

    function ActivateIco () external onlyOwner {
        icoStatus = false;
    }

   function withdraw_unsoldZEPX(uint256 ZEPX_Ammount) public onlyOwner{
        IERC20 ZEPX_TK = IERC20(
            address(0x0Af7aeE626B2641cb1c91c4D42F903D37D88148F) // ZEPX Token address 
        );
       ZEPX_TK.transfer(msg.sender,ZEPX_Ammount);
   }

   function change_Admin_Wallet (address _new_Admin) public onlyOwner {
       Admin_Wallet = _new_Admin;
   }
    
}

