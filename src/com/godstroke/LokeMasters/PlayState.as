package com.godstroke.LokeMasters
{
	import flash.utils.setTimeout;
	
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		private var walls:Array = new Array();
		private var lokeStrike_player:LokeStrike;
		
		private var west_wall:FlxSprite;
		private var north_wall:FlxSprite;
		private var east_wall:FlxSprite;
		private var south_wall:FlxSprite;
		
		private var levelObjective:FlxText;
		
		private var player:LokeMaster;
		private var objectiveArray:Array = new Array();
		private var canCheckObjectives:Boolean =false;
		private var successMessage:String = "";
		private var startingLevel:uint = 0;
		private var currentLevel:uint = 0;
		private var nextLevel:uint = 0;
		
		public function PlayState()
		{
			FlxG.showCursor();
			
			//walls
			west_wall = new FlxSprite(0,0);
			west_wall.createGraphic(1,FlxG.height,0xFF000000);
			west_wall.fixed = true;
			walls.push(west_wall);
			add(west_wall);
			
			north_wall = new FlxSprite(0,0);
			north_wall.createGraphic(FlxG.width,1,0xFF000000);
			walls.push(north_wall);
			north_wall.fixed = true;
			add(north_wall); 
			
			east_wall = new FlxSprite(FlxG.width-1,0);
			east_wall.createGraphic(1,FlxG.height,0xFF000000);
			east_wall.fixed = true;
			walls.push(east_wall);
			add(east_wall); 
			
			south_wall = new FlxSprite(0,FlxG.height-1);
			south_wall.createGraphic(FlxG.width,1,0xFF000000);
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
			setTimeout(function():void{player.blackOut();FlxG.quake(0.035,4);FlxG.flash(0xffffffff,4,function():void{
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
			FlxG.collideArray(walls,player);
		}
		
		// LEVELS
		private function level0():void{
			player =new LokeMaster(FlxG.width/2-6,FlxG.height/2-6);
			add(player);
			
			lokeStrike_player =new LokeStrike(player);
			add(lokeStrike_player);
			
			levelObjective.text = "Welcome Löke Initiate. \nI will guide you on your search of\nsecrets that ancient Löke organisation holds.\n\nNow, press W,A,S,D keys to move...";
			successMessage = "Well Done! Hold on..."
			nextLevel = 0;
			objectiveArray.push(
				function():Boolean
				{
					if(player.x!=FlxG.width/2-6 && player.y!=FlxG.height/2-6)return true;
					else return false; 
				}
			)
			canCheckObjectives = true;
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
