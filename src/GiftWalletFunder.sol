// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "solmate/tokens/ERC20.sol";
import {SafeTransferLib} from "solmate/utils/SafeTransferLib.sol";

contract GiftWalletFunder {
    ERC20 private immutable BZZ_ADDRESS;
    uint256 private immutable BZZ_AMOUNT;
    uint256 private immutable NATIVE_AMOUNT;

    constructor(
        ERC20 bzzAddress,
        uint256 bzzAmount,
        uint256 nativeAmount
    ) {
        BZZ_ADDRESS = bzzAddress;
        BZZ_AMOUNT = bzzAmount;
        NATIVE_AMOUNT = nativeAmount;
    }

    function fund(address payable[] calldata addresses) public payable {
        require(
            addresses.length * NATIVE_AMOUNT == msg.value,
            "incorrect msg.value amount"
        );

        uint256 length = addresses.length;
        for (uint256 i = 0; i < length; ) {
            address payable addr = addresses[i];

            SafeTransferLib.safeTransferETH(addr, NATIVE_AMOUNT);
            SafeTransferLib.safeTransferFrom(
                BZZ_ADDRESS,
                msg.sender,
                addr,
                BZZ_AMOUNT
            );

            unchecked {
                i++;
            }
        }
    }
}
