// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import "forge-std/Vm.sol"; 
import {Voting} from "../src/Voting.sol";
import {Test} from "forge-std/Test.sol";
import {DeployVoting} from "../script/DeployVoting.s.sol";


contract DeployVotingTest is Test {
    DeployVoting public  deployvoting ;
    Voting public voting ;
    address owner ;

   function setUp() external {
    deployvoting = new DeployVoting();
    voting = deployvoting.run();
   owner =  voting.getowner();
   }



   //nopw we can start wihith our tests
//    function testonlyOwnercanaddcandidates() public {
//         vm.prank(voting.getowner()); // now all the following tasks would be done by the owner 
//         // voting.addCandidate("Ayush");
//         // voting.addCandidate("Kanan");
//         // voting.addCandidate("Sarika");
//         //  vm.expectRevert();
//         // vm.prank(OUTSIDER);
//         voting.addCandidate("ayush");
//         bool isCandidate = voting.isValidCandidate("ayush");
//         assertEq(isCandidate,true);
//    }

    function testOwnercannotvoteforcandidates() public {
        vm.expectRevert();
        vm.prank(owner);
        voting.toVoteaCandidate("Ayush");   
    }
    

    //to chekc that the event is emitted 
    function testTOCheckthatEventEmitwhenCandidateAdded() public {
        vm.recordLogs();
        vm.prank(owner);
        voting.addCandidate("Sarika");
        Vm.Log[] memory emittedevent = vm.getRecordedLogs(); // Replace Vm.Log with Log
        //  bytes32 name = emittedevent[1].topics[1];
         assert( emittedevent.length >0);
    }

    function testThatEntreFeeGreaterThan100ether() public {
           address JOHN = makeAddr("JOHN");
            vm.deal(JOHN,100 ether);
            vm.expectRevert();
            vm.prank(JOHN);

            voting.addCandidate{value: 10 ether}("John");      
    }

    function testAndvoteandpickwinner() public{
           address LUIS = makeAddr("LUIS");
            address HARVEY = makeAddr("HARVEY");
             address MIKE = makeAddr("MIKE");

             hoax(LUIS,100 ether);
             voting.addCandidate{value : 70 ether}("LUIS");
              hoax(HARVEY,100 ether);
             voting.addCandidate{value : 100 ether}("HARVEY");
              hoax(MIKE,100 ether);
             voting.addCandidate{value : 60 ether}("MIKE");
              

              address VOTER = makeAddr("VOTER");
                vm.prank(VOTER);
                voting.toVoteaCandidate("HARVEY");

               vm.prank(owner);

                voting.pickWinner();

      
                assert(address(HARVEY).balance == 230 ether);
                 assert(address(voting).balance == 0 );
                 assert (uint256(voting.getvotingstste()) == 1);
      
    }
     

     

       


    }


     






    

