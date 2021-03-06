package com.godstroke.LokeMasters
{
	import flash.utils.setTimeout;
	
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		[Embed(source="../../../data/blackPixel.png")] private var blackPixel:Class;
		
		private var walls:Array = new Array();
		// player
		private var player:LokeMaster;
		private var lokeStrike_player:LokeStrike;
		// friendlies
		private var friendLiesArray:Array =new Array();
		// enemies
		private var enemiesArray:Array =new Array();
		// obstackles
		private var obstacklesArray:Array =new Array();
		// pickables
		private var pickablesArray:Array =new Array();
		// thrown things
		private var projectilesArray:Array =new Array();
		
		private var west_wall:FlxBlock;
		private var north_wall:FlxBlock;
		//private var east_wall:FlxSprite;
		private var east_wall:FlxBlock;
		private var south_wall:FlxBlock;
		
		private var levelObjective:FlxText;
		
		private var objectiveArray:Array = new Array();
		private var canCheckObjectives:Boolean =false;
		private var successMessage:String = "";
		private var startingLevel:uint = 0; // must be 0 on deploy
		private var currentLevel:uint = 0;
		private var nextLevel:uint = 0;
		
		public function PlayState()
		{
			bgColor = 0xFFFFFFFF;
			FlxG.showCursor();
			
			//walls
			west_wall = new FlxBlock(0,0,1,FlxG.height);
			//west_wall.createGraphic(1,FlxG.height,0xFF000000);
			west_wall.loadGraphic(blackPixel,0);
			west_wall.fixed = true;
			walls.push(west_wall);
			add(west_wall);
			
			north_wall = new FlxBlock(0,0,FlxG.width,1);
			//north_wall.createGraphic(FlxG.width,1,0xFF000000);
			north_wall.loadGraphic(blackPixel,0);
			walls.push(north_wall);
			north_wall.fixed = true;
			add(north_wall); 
			
			east_wall = new FlxBlock(FlxG.width-1,0,1,FlxG.height);
			east_wall.loadGraphic(blackPixel,0);
			east_wall.fixed = true;
			walls.push(east_wall);
			add(east_wall); 
			
			south_wall = new FlxBlock(0,FlxG.height-1,FlxG.width,1);
			//south_wall.createGraphic(FlxG.width,1,0xFF000000);
			south_wall.loadGraphic(blackPixel,0);
			south_wall.fixed = true;
			walls.push(south_wall);
			add(south_wall); 
			
			levelObjective = new FlxText(0,0,FlxG.width);
			levelObjective.color = 0xFF000000
			levelObjective.size = 8;
			levelObjective.text ="";
			add(levelObjective);
			// begin
			loadLevel(startingLevel); //savegame yapmak için bıraktım burayı
		}
		
		private function loadLevel(num:uint):void{
			clearLevel();
			this["level"+num]();
			currentLevel = num;
		}
		
		private function passLevel(_to:uint):void{
			FlxG.flash(0xffffffff,0.3);
			setTimeout(function():void{player.blackOut();FlxG.quake(0.0355,4);FlxG.flash(0x55ffffff,4,function():void{
				loadLevel(_to);
			});},3000);
		}
		
		override public function update():void
		{	
			super.update();
			
			// OBJECTIVES, CHECK
			if(canCheckObjectives)
			if(checkObjectives()==true){
				levelObjective.text += "\n\n"+successMessage;
				canCheckObjectives = false;
				passLevel(nextLevel);
			}
			
			FlxG.collideArray(friendLiesArray,player);
			FlxG.collideArrays(friendLiesArray,friendLiesArray);
			FlxG.collideArrays(friendLiesArray,walls);
			
			FlxG.collideArray(walls,player);
			
			FlxG.collideArray(obstacklesArray,player);
			FlxG.collideArrays(friendLiesArray,obstacklesArray);
			FlxG.collideArrays(walls,obstacklesArray);
			FlxG.overlapArray(obstacklesArray,lokeStrike_player,player_hits_obstacle);
			FlxG.overlapArray(pickablesArray,player,player_picks_item);
			FlxG.collideArrays(projectilesArray,walls);
			FlxG.collideArray(enemiesArray,player);
			FlxG.overlapArrays(projectilesArray,enemiesArray,projectile_hits_enemy);
			FlxG.overlapArray(enemiesArray,lokeStrike_player,player_hits_enemy);
			FlxG.overlapArray(friendLiesArray,lokeStrike_player,player_hits_friend);
			FlxG.collideArrays(projectilesArray,obstacklesArray);
		}
		
		private function projectile_hits_enemy(proj:PaperThrowable,enemy:FlxCore):void{
			trace("proj.damage "+proj.damage);
			enemy["hit"](proj.damage);
			proj.justHitSomething();
		}
		
		private function player_hits_friend(ene:FlxCore,player_strike:LokeStrike):void{
			player_strike["justHitSomething"]();
		}
		
		private function player_hits_enemy(ene:FlxCore,player_strike:LokeStrike):void{
			ene["hit"](player_strike.damage);
			player_strike["justHitSomething"]();
		}
		
		private function player_hits_obstacle(obs:FlxCore,strike:FlxCore):void{
			obs["hit"]();
			strike["justHitSomething"]();
		}
		
		private function player_picks_item(item:FlxCore,player:FlxCore):void{
			item["getItem"](player);
		}
		
		public function create_or_claim_projectile():PaperThrowable{
			var ret:PaperThrowable = null
			for each(var pt:PaperThrowable in projectilesArray){
				if(pt.dead && !pt.thrown){
					ret =pt;
				}
			}
			if(!ret){
				ret = new PaperThrowable(5,5);
				add(ret);
				projectilesArray.push(ret)
			}
			return ret;
		}
		
		
		public function createPaperItem(_x:Number,_y:Number,damage:Number=1):PaperItem{
			var pi:PaperItem =new PaperItem(_x,_y,1,damage);
			pickablesArray.push(pi);
			add(pi);
			return pi;
		}
		
		// LEVELS
		//////////////////////
		///////  1  //////////
		//////////////////////
		private function level0():void{
			player =new LokeMaster(FlxG.width/2-6,FlxG.height/2-6);
			add(player);
			
			lokeStrike_player =new LokeStrike(player);
			add(lokeStrike_player);
			
			levelObjective.text = "Welcome Löke Initiate. \nI will guide you on your search of\nsecrets that ancient Löke organisation holds.\n\nNow, press W,A,S,D keys to move...";
			successMessage = "Well Done! Hold on..."
			nextLevel = 1;
			objectiveArray.push(
				function():Boolean
				{
					if(Math.abs(player.x-FlxG.width/2)>20 &&
					   Math.abs(player.y-FlxG.height/2)>20 )return true;
					else return false; 
				}
			)
			canCheckObjectives = true;
		}
		//////////////////////
		///////  2  //////////
		//////////////////////
		private function level1():void{
			player =new LokeMaster(FlxG.width/2-20,FlxG.height/2-6);
			
			lokeStrike_player =new LokeStrike(player);
			var friend:Loke = new Loke(player.x+30,player.y);
			friend.fixed =true;
			friendLiesArray.push(friend);
			
			var trashCan1:TrashCan =new TrashCan(60,160);
			trashCan1.fixed =true;
			obstacklesArray.push(trashCan1);
			var trashCan2:TrashCan =new TrashCan(97,210);
			trashCan2.fixed =true;
			obstacklesArray.push(trashCan2);
			var trashCan3:TrashCan =new TrashCan(160,120);
			trashCan3.fixed =true;
			obstacklesArray.push(trashCan3);
			var trashCan4:TrashCan =new TrashCan(204,129);
			trashCan4.fixed =true;
			obstacklesArray.push(trashCan4);
			var trashCan5:TrashCan =new TrashCan(22,132);
			trashCan5.fixed =true;
			obstacklesArray.push(trashCan5);
			var trashCan6:TrashCan =new TrashCan(219,228);
			trashCan6.fixed =true;
			obstacklesArray.push(trashCan6);
			
			
			add(friend);
			add(player);
			add(trashCan1);
			add(trashCan2);
			add(trashCan3);
			add(trashCan4);
			add(trashCan5);
			add(trashCan6);
			add(lokeStrike_player);
			
			levelObjective.text = "We have just traveled in time. Now is,\nSeptember 21th of 1995. Eralp and Eren are playing\nat the schoolyard, waiting for car to take them home.\n\nPress Space key to hit trash cans with your tie.\nBreak all of them.";
			successMessage = "Good job! Hold tight."
			nextLevel = 2;
			objectiveArray.push(
				function():Boolean
				{
					for each(var can:TrashCan in obstacklesArray){
						if(!can.dead)return false;
					}
					return true;
				}
			)
			canCheckObjectives = true;
		}
		//////////////////////
		///////  3  //////////
		//////////////////////
		private function level2():void{
			player =new LokeMaster(FlxG.width/2-8,FlxG.height-30);
			lokeStrike_player =new LokeStrike(player);
			
			// desk
			var table1:ClassroomTable =new ClassroomTable(70,150);
			table1.fixed = true;
			obstacklesArray.push(table1);
			add(table1);
			
			var friend1:Loke = new Loke(table1.x,table1.y-17);
			friend1.fixed =true;
			friend1._health = 9999
			enemiesArray.push(friend1);
			
			var friend2:Loke = new Loke(table1.x+16,table1.y-17);
			friend2.fixed =true;
			friend2._health = 9999
			enemiesArray.push(friend2);
			
			// desk
			var table2:ClassroomTable =new ClassroomTable(table1.x +64,table1.y);
			table2.fixed = true;
			obstacklesArray.push(table2);
			add(table2);
			
			var friend3:Loke = new Loke(table2.x,table2.y-17);
			friend3.fixed =true;
			friend3._health = 9999
			enemiesArray.push(friend3);
			
			var friend4:Loke = new Loke(table2.x+16,table2.y-17);
			friend4.fixed =true;
			friend4._health = 9999
			enemiesArray.push(friend4);
			
			//desk
			var table3:ClassroomTable =new ClassroomTable(table2.x +64,table2.y);
			table3.fixed = true;
			obstacklesArray.push(table3);
			add(table3);
			
			var friend5:Loke = new Loke(table3.x,table3.y-17);
			friend5.fixed =true;
			friend5._health = 9999
			enemiesArray.push(friend5);
			
			var friend6:Loke = new Loke(table3.x+16,table3.y-17);
			friend6._health = 9999
			friend6.fixed =true;
			enemiesArray.push(friend6);
			
			// desk
			var table4:ClassroomTable =new ClassroomTable(table1.x,table1.y+60);
			table4.fixed = true;
			obstacklesArray.push(table4);
			add(table4);
			
			var friend7:Loke = new Loke(table4.x,table4.y-17);
			friend7.fixed =true;
			friend7._health = 9999
			enemiesArray.push(friend7);
			
			var friend8:Loke = new Loke(table4.x+16,table4.y-17);
			friend8.fixed =true;
			friend8._health = 9999
			enemiesArray.push(friend8);
			
			// desk
			var table5:ClassroomTable =new ClassroomTable(table4.x +64,table4.y);
			table5.fixed = true;
			obstacklesArray.push(table5);
			add(table5);
			
			var friend9:Loke = new Loke(table5.x,table5.y-17);
			friend9.fixed =true;
			friend9._health = 9999
			enemiesArray.push(friend9);
			
			var friend10:Loke = new Loke(table5.x+16,table5.y-17);
			friend10.fixed =true;
			friend10._health = 9999
			enemiesArray.push(friend10);
			
			// desk
			var table6:ClassroomTable =new ClassroomTable(table5.x +64,table5.y);
			table6.fixed = true;
			obstacklesArray.push(table6);
			add(table6);
			
			var friend11:Loke = new Loke(table6.x,table6.y-17);
			friend11.fixed =true;
			friend11._health = 9999
			enemiesArray.push(friend11);
			
			var friend12:Loke = new Loke(table6.x+16,table6.y-17);
			friend12.fixed =true;
			friend12._health = 9999
			enemiesArray.push(friend12);
			// statics done
			
			//required items
			var paper:PaperItem =new PaperItem(100,100,15,10030);
			pickablesArray.push(paper);
			var pen:Pen = new Pen(260,260);
			pickablesArray.push(pen);
			
			// adds
			add(friend1);add(friend2);add(friend3);
			add(friend4);add(friend5);add(friend6);
			add(friend7);add(friend8);add(friend9);
			add(friend10);add(friend11);add(friend12);
			add(paper);
			add(pen);
			
			add(player);
			add(lokeStrike_player);
			
			levelObjective.text = "May 14th of 2002, you are at high school's classroom.\nEmre writes 'Aspersion!' on many small bits of paper,\nthan throws these to other kids, saying:\nI CASTED ASPERSION ON YOU!\n\nFind a pen, a paper.\nThan cast aspersion on all kids by pressing shift key.";
			successMessage = "Shame on you! You are a bad person!"
			nextLevel = 3;
			objectiveArray.push(
				function():Boolean
				{
					for each(var en:Loke in enemiesArray){
						if(!en.dead)return false;
					} 
					return true;
				}
			)
			canCheckObjectives = true;
		}
		//////////////////////
		///////  4  //////////
		//////////////////////
		private function level3():void{
			player =new LokeMaster(FlxG.width/2-6,FlxG.height/2-6);
			add(player);
			
			//lokeStrike_player =new LokeStrike(player);
			//add(lokeStrike_player);
			setTimeout(function():void{player.blackOut()},4000);
			
			levelObjective.text = "ERROR 5734: BAD MEMORY SECTOR.\nMost likely this is the last of the readable records.\nPlease check back later.";
			successMessage = "You will be redirected after few seconds.";
			nextLevel = 0;
			objectiveArray.push(
				function():Boolean
				{
					if(player.dead)return true;
					else return false; 
				}
			)
			canCheckObjectives = true;
		}
		
		//////////////////////
		///////  5  //////////
		//////////////////////
		private function level4():void{
			player =new LokeMaster(FlxG.width/2-6,FlxG.height/2-6);
			add(player);
			
			var loke:Loke =new Loke(60,FlxG.height/2-6);
			loke.AISchema = Loke.wanderingAI;
			add(loke);
			friendLiesArray.push(loke);
			
			var loke2:Loke =new Loke(220,FlxG.height/2-6);
			loke2.AISchema = Loke.wanderingAI;
			add(loke2);
			friendLiesArray.push(loke2);
			
			var loke3:Loke =new Loke(FlxG.width/2-6,70);
			loke3.AISchema = Loke.wanderingAI;
			add(loke3);
			friendLiesArray.push(loke3);
			
			var loke4:Loke =new Loke(FlxG.width/2-6,230);
			loke4.AISchema = Loke.wanderingAI;
			add(loke4);
			friendLiesArray.push(loke4);
			
			//lokeStrike_player =new LokeStrike(player);
			//add(lokeStrike_player);
			//setTimeout(function():void{player.blackOut()},4000);
			
			levelObjective.text = "Random Wandering AI test level.";
			successMessage = "There are no success conditions.";
			nextLevel = 0;
			objectiveArray.push(
				function():Boolean
				{
					if(player.dead)return true;
					else return false; 
				}
			)
			canCheckObjectives = false;
		}
		
		// *
		private function clearLevel():void{
			if(player){
				player.destroy();
				player.dead =true;
				player.visible =false;
			}
			if(lokeStrike_player){
				lokeStrike_player.destroy();
				lokeStrike_player.dead =true;
				lokeStrike_player.visible =false;
			}
			objectiveArray = [];
			
			var f:FlxSprite;
			for each(f in obstacklesArray){f.dead=true; f.destroy(); f.visible=false}
			obstacklesArray =[];
			for each(f in friendLiesArray){f.dead=true; f.destroy(); f.visible=false}
			friendLiesArray =[];
			for each(f in enemiesArray){f.dead=true; f.destroy(); f.visible=false}
			enemiesArray =[];
			for each(f in projectilesArray){f.dead=true; f.destroy(); f.visible=false}
			projectilesArray =[];
			for each(f in pickablesArray){f.dead=true; f.destroy(); f.visible=false}
			pickablesArray =[];
			
			canCheckObjectives = false;
		}
		
		private function checkObjectives():Boolean{
			var allDone:Boolean = true;
			if(objectiveArray.length<=0)return false;
			for each(var f:Function in objectiveArray){
				if(f()==false){allDone=false; break; }
			}
			return allDone;
		}
		
	}
}
