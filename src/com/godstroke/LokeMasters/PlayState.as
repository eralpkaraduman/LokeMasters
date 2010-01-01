package com.godstroke.LokeMasters
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		private var walls:Array = new Array();
		private var lokeStrike_player:LokeStrike;
		
		private var west_wall:FlxSprite;
		private var north_wall:FlxSprite;
		private var east_wall:FlxSprite;
		private var south_wall:FlxSprite;
		
		private var player:LokeMaster;
		
		public function PlayState()
		{
			FlxG.showCursor();
			//add(new FlxText(0,0,100,"INSERT GAME HERE"));
			
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
			
			//char test
			player =new LokeMaster(FlxG.width/2,FlxG.height/2);
			add(player);
			
			lokeStrike_player =new LokeStrike(player);
			add(lokeStrike_player);
		}
		
		override public function update():void
		{	
			super.update();
			
			FlxG.collideArray(walls,player);
		}
		
	}
}
