pragma solidity >=0.4.21;

import "./Token.sol";

contract EthSwap{
    string public name="EthSwap Instant Exchange";//State variable on blockchain
    Token public token;
    uint public rate =100;


    event TokensPurchased(
        address account,
        address token,
        uint amount,
        uint rate
    );


    event TokensSold(
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
        require(token.balanceOf(address(this)) >= tokenAmount);

        token.transfer(msg.sender,tokenAmount);

        //Emit an event
        emit TokensPurchased(msg.sender, address(token), tokenAmount, rate);
    }



    function sellTokens(uint _amount) public {

        //User cant sell more tokens than they have
        require(token.balanceOf(msg.sender) >= _amount);
        
        //Calculate the amount of Ether to redeem
        uint etherAmount =_amount/rate;

        //Require that EthSwap has enough Ether
        require(address(this).balance >= etherAmount);
        

        // Perform sale
        token.transferFrom(msg.sender,address(this), _amount);
        msg.sender.transfer(etherAmount);

        //emit an Event

        emit TokensSold(msg.sender,address(token), _amount,rate);
    }
}
