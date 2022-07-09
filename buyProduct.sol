//SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

contract buyProduct{
    uint public quantite;
    
    mapping(address=>uint) public balanceOf;
    address internal proprio ;
    address internal acheteur;
    uint public aPayer;
    uint internal chiffreAffaire;

    constructor(){
        proprio = msg.sender;
        balanceOf[address(this)] = 100;
    }

    function achat(uint unites) public{
        require(proprio != msg.sender, "Le vendeur ne peut pas acheter");
        acheteur = msg.sender;
        aPayer = unites * 3 ether;
        quantite = unites;
     
    }

    function stockage(uint restockage) public{
        require(proprio == msg.sender, "Seul le veneur peut restocker");
        require(balanceOf[address(this)]< 50, "La balance est au dessus de 50");
        balanceOf[address(this)] += restockage;

    }
    function pay() public payable{
        require( acheteur== msg.sender, "vous n'etes pas l'acheteur");
        require(aPayer == msg.value,"verifiez le montant a payer");
       payable(proprio).transfer(aPayer);
        balanceOf[address(this)] -= quantite;
        balanceOf[address(msg.sender)] += quantite;
        
    }
    function stock_disponible() public view returns(uint){
        return balanceOf[address(this)];
    }
    
    
}