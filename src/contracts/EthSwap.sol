pragma solidity >=0.4.21;

import "./Token.sol";

contract EthSwap{
    string public name="EthSwap Instant Exchange";//State variable on blockchain
    Token public token;
    uint public rate =100;


    event TokenPurchased(
        address account,
        address token,
        uint amount,
        uint rate
    );

    constructor(Token _token) public{ //_token is not on blockchian its a local variable 
        token = _token;//token on blockchain 
    }

    function buyTokens() public payable{
        //Redemption rate =NO of tokens they receive for 1 ether
        //Amount of Etherum*Redemption rate
        uint tokenAmount = msg.value * rate;
        token.transfer(msg.sender,tokenAmount);

        //Emit an event
        emit TokenPurchased(msg.sender, address(token), tokenAmount, rate);
    }
}
