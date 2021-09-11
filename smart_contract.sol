// MONO ICO

// Version of compiler
pragma solidity 0.5.1;

contract mono_ico {
 
    // Introducing the maximum number of MONO available for sale
    uint public max_mono = 1000000;
 
    // Introducing the USD to MONO conversion rate
    uint public usd_to_mono = 1000;
 
    // Introducing the total number of MONO that have been bought by the investors
    uint public total_mono_bought = 0;
 
    // Mapping from the investor address to its equity in MONO and USD
    mapping(address => uint) equity_mono;
    mapping(address => uint) equity_usd;
 
    // Checking if an investor can buy MONO
    modifier can_buy_mono(uint usd_invested) {
        require (usd_invested * usd_to_mono + total_mono_bought <= max_mono);
        _;
    }
 
    // Getting the equity in MONO of an investor
    function equity_in_mono external view returns (uint){
        return equity_mono[investor];
    }
    
    // Getting the equity in USD of an investor
    function equity_in_usd(address investor) external view returns (uint){
        return equity_usd[investor];
    }
 
    // Buying MONO
    function buy_mono(address investor, uint usd_invested) external 
    can_buy_mono(usd_invested) {
        uint mono_bought = usd_invested * usd_to_mono;
        equity_mono[investor] += mono_bought;
        equity_usd[investor] = equity_mono[investor] / 1000;
        total_mono_bought += mono_bought;
    }
 
    // Selling MONO
    function sell_mono(address investor, uint mono_sold) external {
        equity_mono[investor] -= mono_sold;
        equity_usd[investor] = equity_mono[investor] / 1000;
        total_mono_bought -= mono_sold;
    }
}