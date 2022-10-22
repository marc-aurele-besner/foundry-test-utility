// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import '../utils/console.sol';
import { Vm } from '../utils/vm.sol';
import { DSTest } from '../utils/test.sol';

contract Signatures is DSTest {
    Vm private constant vm = Vm(address(uint160(uint256(keccak256('hevm cheat code')))));

    uint256 SIGNER1_PRIVATEKEY = 1;
    uint256 SIGNER2_PRIVATEKEY = 2;
    uint256 SIGNER3_PRIVATEKEY = 3;
    uint256 SIGNER4_PRIVATEKEY = 4;
    uint256 SIGNER5_PRIVATEKEY = 5;

    address SIGNER1 = vm.addr(SIGNER1_PRIVATEKEY);
    address SIGNER2 = vm.addr(SIGNER2_PRIVATEKEY);
    address SIGNER3 = vm.addr(SIGNER3_PRIVATEKEY);
    address SIGNER4 = vm.addr(SIGNER4_PRIVATEKEY);
    address SIGNER5 = vm.addr(SIGNER5_PRIVATEKEY);

    enum SignatureType {
        eip191,
        eip712
    }

    function signature_signHashEip191(bytes32 hash_) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked('\x19Ethereum Signed Message:\n32', hash_));
    }

    function signature_signHashEip712(bytes32 domainSeparator_, bytes32 hash_) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked('\x19\x01', domainSeparator_, hash_));
    }

    function signature_signHash(
        uint256 signerPrivateKey_,
        SignatureType signatureType_,
        bytes32 domainSeparator_,
        bytes32 hash_
    )
        internal
        virtual
        returns (
            uint8 v,
            bytes32 r,
            bytes32 s
        )
    {
        if (signatureType_ == SignatureType.eip191) {
            (v, r, s) = vm.sign(signerPrivateKey_, signature_signHashEip191(hash_));
        } else {
            (v, r, s) = vm.sign(signerPrivateKey_, signature_signHashEip712(domainSeparator_, hash_));
        }
    }

    function signature_signHashed(
        uint256 signerPrivateKey_,
        SignatureType signatureType_,
        bytes32 domainSeparator_,
        bytes32 hash_
    ) internal virtual returns (bytes memory signature) {
        uint8 v;
        bytes32 r;
        bytes32 s;

        if (signatureType_ == SignatureType.eip191) {
            (v, r, s) = vm.sign(signerPrivateKey_, signature_signHashEip191(hash_));
        } else {
            (v, r, s) = vm.sign(signerPrivateKey_, signature_signHashEip712(domainSeparator_, hash_));
        }
        signature = abi.encodePacked(r, s, v);
    }

    function signature_signHash(
        uint256 signerPrivateKey_,
        bytes32 domainSeparator_,
        bytes32 hash_
    )
        internal
        virtual
        returns (
            uint8 v,
            bytes32 r,
            bytes32 s
        )
    {
        (v, r, s) = vm.sign(signerPrivateKey_, signature_signHashEip712(domainSeparator_, hash_));
    }

    function signature_signHashed(
        uint256 signerPrivateKey_,
        bytes32 domainSeparator_,
        bytes32 hash_
    ) internal virtual returns (bytes memory signature) {
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerPrivateKey_, signature_signHashEip712(domainSeparator_, hash_));
        signature = abi.encodePacked(r, s, v);
    }

    function signature_signHash(uint256 signerPrivateKey_, bytes32 hash_)
        internal
        virtual
        returns (
            uint8 v,
            bytes32 r,
            bytes32 s
        )
    {
        (v, r, s) = vm.sign(signerPrivateKey_, signature_signHashEip191(hash_));
    }

    function signature_signHashed(uint256 signerPrivateKey_, bytes32 hash_) internal virtual returns (bytes memory signature) {
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerPrivateKey_, signature_signHashEip191(hash_));
        signature = abi.encodePacked(r, s, v);
    }
}
