// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ESPLARENA is ERC20, AccessControl {
    using SafeMath for uint256;
    
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    
    mapping(address => uint256) private _balances; 
    uint256 private _totalSupply;
    uint256 constant MAXIMUMSUPPLY=1000000000*10**18;

    constructor() ERC20("ESPL ARENA", "ARENA") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        require((_totalSupply+amount)<=MAXIMUMSUPPLY,"Maximum supply has been reached");
        _totalSupply = _totalSupply.add(amount);
        _balances[to] = _balances[to].add(amount);
        _mint(to, amount);
    }

    function totalSupply() public override view returns (uint256) {
    return _totalSupply; 
    }

    function maxSupply() public  pure returns (uint256) {
    return MAXIMUMSUPPLY;
    }
}
