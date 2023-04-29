// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/* l00kin Citizen ID
██╗      ██████╗  ██████╗ ██╗  ██╗██╗███╗   ██╗
██║     ██╔═████╗██╔═████╗██║ ██╔╝██║████╗  ██║
██║     ██║██╔██║██║██╔██║█████╔╝ ██║██╔██╗ ██║
██║     ████╔╝██║████╔╝██║██╔═██╗ ██║██║╚██╗██║
███████╗╚██████╔╝╚██████╔╝██║  ██╗██║██║ ╚████║
╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝

 ██████╗██╗████████╗██╗███████╗███████╗███╗   ██╗    ██╗██████╗
██╔════╝██║╚══██╔══╝██║╚══███╔╝██╔════╝████╗  ██║    ██║██╔══██╗
██║     ██║   ██║   ██║  ███╔╝ █████╗  ██╔██╗ ██║    ██║██║  ██║
██║     ██║   ██║   ██║ ███╔╝  ██╔══╝  ██║╚██╗██║    ██║██║  ██║
╚██████╗██║   ██║   ██║███████╗███████╗██║ ╚████║    ██║██████╔╝
 ╚═════╝╚═╝   ╚═╝   ╚═╝╚══════╝╚══════╝╚═╝  ╚═══╝    ╚═╝╚═════╝
*/

contract L00kinCitizenID is ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;

    uint8 public mintStatus = 0;

    string baseURI;
    uint256 constant public MAX_SUPPLY = 10000; // Max Supply
    uint256 constant public PRICE = 100000000000000000; // 0.1 ETH
    bytes4 private constant _INTERFACE_ID_ERC2981 = 0x2a55205a;

    Counters.Counter private _tokenIds;

    constructor() ERC721("L00KIN CITIZEN ID", "L00KID") {}

    function setMintStatus(uint8 _status) public onlyOwner {
        mintStatus = _status;
    }

    function setBaseURI(string memory baseURI_) public onlyOwner {
        baseURI = baseURI_;
    }

    function getBaseURI() public view returns (string memory) {
        return baseURI;
    }

    function tokenURI(uint256 tokenId) override public view returns (string memory) {
        string memory path = baseURI;
        return bytes(path).length > 0 ? string(abi.encodePacked(path, Strings.toString(tokenId))) : "";
    }

    function mint() public payable returns (bool) {
        require(mintStatus > 0, "Mint is not started yet");
        require(balanceOf(msg.sender) == 0, "User can mint citizen ID only once");
        require(totalSupply() < MAX_SUPPLY, "Max supply of tokens exceeded");
        require(msg.value >= PRICE, "Not enough funds to mint citizen ID");
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();
        _mint(msg.sender, newTokenId);
        return true;
    }

    function withdraw() public onlyOwner payable {
        uint256 balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }
}
