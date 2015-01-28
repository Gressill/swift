//
//  ViewController.swift
//  Tac_toe
//
//  Created by Fei Yu on 27/01/15.
//  Copyright (c) 2015 Fei Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var ticTagImg1: UIImageView!
    @IBOutlet var ticTagImg2: UIImageView!
    @IBOutlet var ticTagImg3: UIImageView!
    @IBOutlet var ticTagImg4: UIImageView!
    @IBOutlet var ticTagImg5: UIImageView!
    @IBOutlet var ticTagImg6: UIImageView!
    @IBOutlet var ticTagImg7: UIImageView!
    @IBOutlet var ticTagImg8: UIImageView!
    @IBOutlet var ticTagImg9: UIImageView!
    
    @IBOutlet var ticTacBtn1: UIButton!
    @IBOutlet var ticTacBtn2: UIButton!
    @IBOutlet var ticTacBtn3: UIButton!
    @IBOutlet var ticTacBtn4: UIButton!
    @IBOutlet var ticTacBtn5: UIButton!
    @IBOutlet var ticTacBtn6: UIButton!
    @IBOutlet var ticTacBtn7: UIButton!
    @IBOutlet var ticTacBtn8: UIButton!
    @IBOutlet var ticTacBtn9: UIButton!
    
    @IBOutlet var resetBtn: UIButton!
    
    @IBOutlet var userMessage: UILabel!
    
    var Decks = Dictionary<Int,Int>();
    var aiDeciding:Bool = false
    var done:Bool = false
    
    @IBAction func UIbuttonClicked(Sender:UIButton){
        userMessage.hidden = true;
        //println("here is is: \(Sender.tag)");
        if (Decks[Sender.tag] == nil && !aiDeciding && !done ) {
            setImgForSpot(Sender.tag,player:1);
        }
        //println("here 3");
        checkForWin();
        if(!done){
            aiTurn();
        }
        
    }
    
    func setImgForSpot(spot:Int,player:Int){
        var playerId = player == 1 ? "x":"o";
        Decks[spot] = player;
        println("Decks \(spot) is : \(player)");
        switch spot{
        case 1:
            ticTagImg1.image = UIImage(named: playerId);
        case 2:
            ticTagImg2.image = UIImage(named: playerId);
        case 3:
            ticTagImg3.image = UIImage(named: playerId);
        case 4:
            ticTagImg4.image = UIImage(named: playerId);
        case 5:
            ticTagImg5.image = UIImage(named: playerId);
        case 6:
            ticTagImg6.image = UIImage(named: playerId);
        case 7:
            ticTagImg7.image = UIImage(named: playerId);
        case 8:
            ticTagImg8.image = UIImage(named: playerId);
        case 9:
            ticTagImg9.image = UIImage(named: playerId);
        default:
            ticTagImg9.image = UIImage(named: playerId);
            
        }
        checkForWin();
    }
    
    @IBAction func resetBtnClicked(Sender:UIButton){
        reset();
    }
    
    func reset(){
        Decks = [:]
        done = false;
        ticTagImg1.image = nil;
        ticTagImg2.image = nil;
        ticTagImg3.image = nil;
        ticTagImg4.image = nil;
        ticTagImg5.image = nil;
        ticTagImg6.image = nil;
        ticTagImg7.image = nil;
        ticTagImg8.image = nil;
        ticTagImg9.image = nil;
        userMessage.text = "";
        userMessage.hidden = true;
        resetBtn.hidden = true;
    }
    
    func checkForWin(){
        var whoWins:Dictionary = ["I":0,"You":1];
        for (key, value) in whoWins {
            let ex1 = (Decks[1] == value) && (Decks[2] == value) && (Decks[3] == value);
            let ex2 = (Decks[4] == value && Decks[5] == value && Decks[6] == value);
            let ex3 = Decks[7] == value && Decks[8] == value && Decks[9] == value;
            let ex4 = Decks[1] == value && Decks[5] == value && Decks[9] == value;
            let ex5 = Decks[3] == value && Decks[5] == value && Decks[7] == value;
            let ex6 = Decks[1] == value && Decks[4] == value && Decks[7] == value;
            let ex7 = Decks[2] == value && Decks[5] == value && Decks[8] == value;
            let ex8 = Decks[3] == value && Decks[6] == value && Decks[9] == value;
            if(ex1 || ex2 || ex3 || ex4 || ex5 || ex6 || ex7 || ex8){
                userMessage.hidden = false;
                userMessage.text = "looks like \(key) win!";
                resetBtn.hidden = false;
                done = true;
            }
        }
    }
    
    func isOcupied(spot:Int)->Bool{
        if(Decks[spot] == 0 || Decks[spot] == 1){
            return true;
        }
        return false;
    }
    
    func findTop(#playerSign:Int)->(location:String,patten:String){
        return ("top",checkFor(playerSign, inList: [1,2,3]));
    }
    
    func findMid(#playerSign:Int)->(location:String,patten:String){
        return ("mid",checkFor(playerSign, inList: [4,5,6]));
    }
    
    func findBottom(#playerSign:Int)->(location:String,patten:String){
        return ("btm",checkFor(playerSign, inList: [7,8,9]));
    }
    
    func findLeft(#playerSign:Int)->(location:String,patten:String){
        return ("left",checkFor(playerSign, inList: [1,4,7]));
    }
    
    func findRight(#playerSign:Int)->(location:String,patten:String){
        return ("right",checkFor(playerSign, inList: [3,6,9]));
    }
    
    func findCenter(#playerSign:Int)->(location:String,patten:String){
        return ("cter",checkFor(playerSign, inList: [2,5,8]));
    }
    
    func findLeftDown(#playerSign:Int)->(location:String,patten:String){
        return ("leftdown",checkFor(playerSign, inList: [1,3,9]));
    }
    
    func findRightDown(#playerSign:Int)->(location:String,patten:String){
        return ("rightdown",checkFor(playerSign, inList: [3,5,7]));
    }
    
    func checkFor(playerSign:Int,inList:[Int]) ->String{
        var patten = "";
        for i in inList {
            if Decks[i] == playerSign {
                patten+="1";
            }else{
                patten+="0";
            }
        }
        return patten;
    }
    
    func rowCheck(#value:Int) ->(location:String,patten:String)?{
        println(Decks);
        var winPatten = ["110","101","011"];
        var findFuncs = [findTop,findMid,findBottom,findLeft,findRight,findCenter,findLeftDown,findRightDown];
        for findFunc in findFuncs {
            var findFuncResult = findFunc(playerSign:value)
            //println("find :  \(find(winPatten,findFuncResult.patten))");
           // println(findFunc);
            //println(findFuncResult.patten);
            if (find(winPatten,findFuncResult.patten) != nil){
               return findFuncResult;
            }
        }
        return nil;
    }
    
    
    func whereToput(location:String,patten:String)->Int{
        var left = "011";
        var mid = "101";
        var right = "110";
        
        switch location {
            case "top":
                if(patten == left){
                    return 1;
                }else if(patten == mid){
                    return 2;
                }else{
                    return 3;
            }
        case "mid":
            if(patten == left){
                return 4;
            }else if(patten == mid){
                return 5;
            }else{
                return 6;
            }
        case "btm":
            if(patten == left){
                return 7;
            }else if(patten == mid){
                return 8;
            }else{
                return 9;
            }
        case "left":
            if(patten == left){
                return 1;
            }else if(patten == mid){
                return 4;
            }else{
                return 7;
            }
        case "cter":
            if(patten == left){
                return 2;
            }else if(patten == mid){
                return 5;
            }else{
                return 8;
            }
        case "right":
            if(patten == left){
                return 3;
            }else if(patten == mid){
                return 6;
            }else{
                return 9;
            }
        case "leftdown":
            if(patten == left){
                return 1;
            }else if(patten == mid){
                return 5;
            }else{
                return 9;
            }
        case "rightdown":
            if(patten == left){
                return 3;
            }else if(patten == mid){
                return 5;
            }else{
                return 7;
            }
        default:
            println(location+patten);
                return -1;
        }
        
    }
    
    func putAI(location:Int)->Bool{
        if(!isOcupied(location)){
            setImgForSpot(location, player: 0);
            aiDeciding = false;
            return true;
        }
        return false
    }
    
    func aiTurn(){
        aiDeciding = true;
        //ai has two "O" in one row
        if let result = rowCheck(value: 0){
            var loc = whereToput(result.location,patten: result.patten);
            if(putAI(loc)){
                return
            }
        }
        //I have two "X" in one row
        if let result = rowCheck(value: 1){
            var loc = whereToput(result.location,patten: result.patten);
            println(result);
            if(putAI(loc)){
                return
            }
        }
        //AI get the center
        if(!isOcupied(5)){
            setImgForSpot(5, player: 0);
            //checkForWin();
            aiDeciding = false;
            return;
        }
        //AI get the coner
        for i in [1,3,7,9]{
            if(!isOcupied(i)){
                setImgForSpot(i, player: 0);
                //checkForWin();
                aiDeciding = false;
                return;
            }
        }
        
        //AI get the edge
        for i in [2,4,6,8]{
            if(!isOcupied(i)){
                setImgForSpot(i, player: 0);
                //checkForWin();
                aiDeciding = false;
                return;
            }
        }
        
        //tie game
        userMessage.hidden = false;
        userMessage.text = "looks like Tie!";
        resetBtn.hidden = false;
        done = true;
        aiDeciding = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

