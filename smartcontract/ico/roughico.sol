// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "./safeMath.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC20/ERC20.sol";

contract Crowdsale {
    using SafeMath for uint256;

    ERC20 public token;
    address public wallet;
    uint256 public rate;
    uint256 public weiRaised;

    event TokenPurchase(
        address indexed purchaser,
        address indexed investor,
        uint256 value,
        uint256 amount
    );

    constructor(
        uint256 _rate,
        address _wallet,
        ERC20 _token
    ) public {
        require(_rate > 0);
        require(_wallet != address(0));
        require(_token != address(0));

        rate = _rate;
        wallet = _wallet;
        token = _token;
    }



    function buyTokens(address _investor) public payable {
        uint256 weiAmount = msg.value;
        _preValidatePurchase(_investor, weiAmount);

        uint256 tokens = _getTokenAmount(weiAmount);
        weiRaised = weiRaised.add(weiAmount);

        _processPurchase(_investor, tokens);
        emit TokenPurchase(msg.sender, _investor, weiAmount, tokens);

        _updatePurchasingState(_investor, weiAmount);

        _forwardFunds();
        _postValidatePurchase(_investor, weiAmount);
    }

    function _preValidatePurchase(address _investor, uint256 _weiAmount)
        internal
    {
        require(_investor != address(0));
        require(_weiAmount != 0);
    }

    function _postValidatePurchase(address _investor, uint256 _weiAmount)
        internal
    {
      
    }

    function _deliverTokens(address _investor, uint256 _tokenAmount) internal {
        token.transfer(_investor, _tokenAmount);
    }

    function _processPurchase(address _investor, uint256 _tokenAmount)
        internal
    {
        _deliverTokens(_investor, _tokenAmount);
    }

    function _updatePurchasingState(address _investor, uint256 _weiAmount)
        internal
    {
      
    }

    function _getTokenAmount(uint256 _weiAmount)
        internal
        view
        returns (uint256)
    {
        return _weiAmount.mul(rate);
    }

    function _forwardFunds() payable internal {
        wallet.transfer(msg.value);
    }
}
