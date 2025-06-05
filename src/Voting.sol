//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Voting{

    event registeredAsacandidate(string indexed candidate);
    event NameOfWinner(string indexed winner);


    address public immutable i_owner;
    uint256  i_entrancefee;
    
    
    enum VotingState{
        CLOSE, //0
        OPEN   //1
    }
     
     VotingState private s_votingstate ;

    constructor(){
        i_owner = msg.sender;
        i_entrancefee = 50 ether;
        s_votingstate = VotingState.OPEN; // so default we set the voting stste to be o
    }


    /*errors*/
     error HasAlreadyVoted(address caller);
     error AlreadyACandidate();
     error Notowner();
     error OwnerCantVote(address caller);
     error Voting_for_a_Nonexisting_candidate();
     error VotingtIMEpASSED();
     error NotEnoughMoney();
     error Transferfailed();
     error NocandidatesAdded();


    modifier OnlyOwner(){
        if(msg.sender != i_owner){
            revert Notowner();
        }
        _;
    }
    
    
    //adding candidate to the voting
    struct candidate{
        string name;
        uint256 countofvote;
        address payable addressofcandidate;
    }

    candidate[] public listofcandidates;
     mapping (string =>uint256) public nametovotes;
     mapping (string=>bool) public isValidCandidate; 
    //add candidate with initial vote = 0 
    function addCandidate(string memory nameofCandidate) external payable {
       if(isValidCandidate[nameofCandidate]){
           revert AlreadyACandidate();
       }

       if(msg.value < i_entrancefee ){
        revert NotEnoughMoney();
       }

        listofcandidates.push(candidate(nameofCandidate,0,payable(msg.sender)));
        nametovotes[nameofCandidate] = 0;
        isValidCandidate[nameofCandidate] = true;
        emit registeredAsacandidate(nameofCandidate);
    
    }

    //to keep track of all those who have voted
    mapping (address => bool) public hasVoted;

  // to vote a candidate and we cant pass msg.sender as a function argument 

    address [] private voters;

    function toVoteaCandidate(string memory nameofCandidate) public  {
           
        if(s_votingstate == VotingState.CLOSE){
             revert VotingtIMEpASSED();
        }
         if(hasVoted[msg.sender]){
            revert HasAlreadyVoted(msg.sender);
         }
         else if(msg.sender == i_owner){
             revert OwnerCantVote(msg.sender);
         }
         else if(!isValidCandidate[nameofCandidate]){
             revert Voting_for_a_Nonexisting_candidate();

         }
         else{
            nametovotes[nameofCandidate]++;
            hasVoted[msg.sender] = true;
            voters.push(msg.sender) ;
         }
}

    function pickWinner() external OnlyOwner {
        //what is no candidate is added 
        if(listofcandidates.length ==0){
            revert NocandidatesAdded();
        }

        s_votingstate = VotingState.CLOSE;
        uint256 winnerIndex = 0  ;
         string memory winner = listofcandidates[0].name;
         for(uint256 i = 1 ; i < listofcandidates.length ; i ++ ){
            if(nametovotes[winner]< nametovotes[listofcandidates[i].name] ){
                winner = listofcandidates[i].name;
                  winnerIndex = i;
            }
            else{
                continue;
            }
         }    
            
         emit NameOfWinner(string(winner));
        
         address payable winneraddress = listofcandidates[winnerIndex].addressofcandidate;
         (bool success,) = winneraddress.call{value : address(this).balance}(""); 
         if(!success){
          revert Transferfailed();
        }


        //reset
       
        for (uint i = 0; i < listofcandidates.length; i++) {
         string memory name = listofcandidates[i].name;
           delete nametovotes[name];         
          delete isValidCandidate[name];     
         }
         delete listofcandidates;

         for(uint i = 0; i < voters.length; i++){
           delete hasVoted[voters[i]];
     }
          delete voters;


         s_votingstate = VotingState.OPEN;
    }

function getowner() public view  returns(address){
    return i_owner;
}

function getvotingstste() public view returns(VotingState) {
    return s_votingstate;
}


}