// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./Curse.sol";


contract Materials is ERC1155,Ownable{
    using SafeMath for uint256;

    Curse private curse_contract;

    uint256[] material_supply=[100,700,100,100];
    string[] asset_names=["water","salt","gold","rare_alloy","Potion1","Potion2","Sacred_Water"];
    uint256[] current_supply=[0,0,0,0,0,0,0];
    uint256[] ids=[0,1,2,3,4,5,6];

    constructor() ERC1155(""){
        curse_contract=new Curse();
    }

    function increase_Supply(uint256[] memory _supply) external onlyOwner {
        require(_supply.length==material_supply.length);
        material_supply=_supply;
    }

    function mint_material(uint256 _id,uint256 _amount) public {
        require(_amount<=material_supply[_id]-current_supply[_id],"Cannot mint more than supply");
        require(_id<=3,"Not an material id");
        _setURI(asset_names[_id]);
        _mint(msg.sender,_id,_amount,"");
        current_supply[_id].add(_amount);
    }

    function mint_potion1(uint256 _amount) public {
       _burn(msg.sender,0,_amount*2);
       current_supply[0].sub(_amount*2);
       _burn(msg.sender,2,_amount*4);
       current_supply[2].sub(_amount*4);
        _setURI(asset_names[4]);
        _mint(msg.sender,4,_amount,"");
        current_supply[4].add(_amount);
    }
    function mint_potion2(uint256 _amount) public {
        _burn(msg.sender,1,_amount*2);
       current_supply[1].sub(_amount*2);
       _burn(msg.sender,3,_amount*4);
       current_supply[3].sub(_amount*4);
        _setURI(asset_names[5]);
        _mint(msg.sender,5,_amount,"");
        current_supply[5].add(_amount);
    }

    function mint_sacred_water(uint256 _amount) public {
        _burn(msg.sender,2,_amount*2);
       current_supply[2].sub(_amount*2);
       _burn(msg.sender,3,_amount*4);
       current_supply[3].sub(_amount*4);
        _setURI(asset_names[6]);
        _mint(msg.sender,6,_amount,"");
        current_supply[6].add(_amount);
    }

    function Curse_somone(address _to,uint256 _id) public {
        require(_id<=2);
        require(balanceOf(msg.sender,4)>0);
        _burn(msg.sender,4,1);
        curse_contract.curse(_to,_id);
    }

    function potion1_curse_balance(uint256 _id) public returns(uint256) {
        return curse_contract.balanceOf(msg.sender,_id);
    }

    function invoke_curse_of_potion1(uint256 _id) public {
        require(_id <=2);
        require(curse_contract.balanceOf(msg.sender,_id) >0,"You are not cursed");
        if (_id==1){
            _burn(msg.sender,6,2);
        }
        else{
            _burn(msg.sender,6,1);
        }
        curse_contract.revive(msg.sender,_id);

    }
}
