// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "solmate/tokens/ERC20.sol";
import {SafeTransferLib} from "solmate/utils/SafeTransferLib.sol";

contract GiftWalletFunder {
    function fund(
        ERC20 token,
        uint256 tokenAmount,
        uint256 nativeAmount,
        address payable[] calldata addresses
    ) public payable {
        require(
            addresses.length * nativeAmount == msg.value,
            "incorrect msg.value amount"
        );

        uint256 length = addresses.length;
        for (uint256 i = 0; i < length; ) {
            address payable addr = addresses[i];

            SafeTransferLib.safeTransferETH(addr, nativeAmount);
            SafeTransferLib.safeTransferFrom(
                token,
                msg.sender,
                addr,
                tokenAmount
            );

            unchecked {
                i++;
            }
        }
    }
}
