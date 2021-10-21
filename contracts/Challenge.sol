// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;


////////////////////////////
/// GENERAL INSTRUCTIONS ///
////////////////////////////


//////////////////////////////
/// CHALLENGE INSTRUCTIONS ///
//////////////////////////////

// 1. Fill in the contract's functions so that the unit tests pass in tests/Challenge.spec.ts
// 2. Since unit tests are prewritten, please do not rename functions or variables

contract Challenge {
  uint256 public x;
  uint256 public y;
  uint256 public z;

  /// @dev delegate incrementX to the Incrementor contract below
  /// @param inc address to delegate increment call to
  function incrementX(address inc) external {
    require(address(inc) != address(0), "Address zero");
    require(isContract(inc), "Not contract!");
    require(inc.call(bytes4(keccak256("incrementX()"))));
    require(inc.delegatecall(bytes4(keccak256("incrementX()"))));
  }

  /// @dev delegate incrementY to the Incrementor contract below
  /// @param inc address to delegate increment call to
  function incrementY(address inc) external {
    require(address(inc) != address(0), "Address zero");
    require(isContract(inc), "Not contract!");
    require(inc.call(bytes4(keccak256("incrementY()"))));
    require(inc.delegatecall(bytes4(keccak256("incrementY()"))));
  }

  /// @dev delegate incrementZ to the Incrementor contract below
  /// @param inc address to delegate increment call to
  function incrementZ(address inc) external {
    require(address(inc) != address(0), "Address zero");
    require(isContract(inc), "Not contract!");
    require(inc.call(bytes4(keccak256("incrementZ()"))));
    require(inc.delegatecall(bytes4(keccak256("incrementZ()"))));
  }

  /// @dev determines if argument account is a contract or not
  /// @param account address to evaluate
  /// @return bool if account is contract or not

  function isContract(address account) internal view returns (bool) {
    uint256 size;
    assembly {
        size := extcodesize(account)
    }
    return size > 0;
  }

  /// @dev converts address to uint256
  /// @param account address to convert
  /// @return uint256
  function addressToUint256(address account) external pure returns (uint256) {
    return uint256(account);
  }

  /// @dev converts uint256 to address
  /// @param num uint256 number to convert
  /// @return address
  function uint256ToAddress(uint256 num) external pure returns (address) {
    return address(num);
  }

  /// @dev computes uniswapV2 pair address
  /// @param token0 address of first token in pair
  /// @param token1 address of second token in pair
  /// @return address of pair
  function getUniswapV2PairAddress(address token0, address token1)
    external
    pure
    returns (address)
  {
    require(address(token0) != address(0), "Address zero");
    require(address(token1) != address(0), "Address zero");

    // Uniswap factory: 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f
    // UniswapV2Pair contract createCode: 0x96e8ac4277198ff8b6f785478aa9a39f403cb768dd02cbee326c3e7da348845f;

    address factory = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;

    address pair = address(uint(keccak256(abi.encodePacked(
      hex'ff',
      factory,
      keccak256(abi.encodePacked(token0, token1)),
      hex'96e8ac4277198ff8b6f785478aa9a39f403cb768dd02cbee326c3e7da348845f'
    ))));
    return pair;
  }
}

contract Incrementor {
  uint256 public y;
  uint256 public z;
  uint256 public x;

  function incrementX() external {
    x++;
  }

  function incrementY() external {
    y++;
  }

  function incrementZ() external {
    z++;
  }
}
