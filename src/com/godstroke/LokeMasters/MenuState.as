package com.godstroke.LokeMasters
{
	import org.flixel.*;

	public class MenuState extends FlxState
	{
		private var walls:Array =new Array();
		private var west_wall:FlxSprite;
		private var north_wall:FlxSprite;
		private var east_wall:FlxSprite;
		private var south_wall:FlxSprite;
		
		public function MenuState()
		{
			bgColor = 0xFFFFFFFF;
			FlxG.showCursor();
			var t:FlxText;
			
			t = new FlxText(0,FlxG.height/2-90,FlxG.width,"Löke Masters");
			t.size = 24;
			t.color = 0xFF000000
			t.alignment = "center";
			add(t);
			t = new FlxText(0,t.y+35,FlxG.width,"This game is designed&programed");
			t.alignment = "center";
			t.color = 0xFF000000
			add(t);
			t = new FlxText(0,t.y+10,FlxG.width,"by Eralp Karaduman as thanks to people who");
			t.alignment = "center";
			t.color = 0xFF000000
			add(t);
			t = new FlxText(0,t.y+10,FlxG.width,"had been his friends for more than a decade.");
			t.alignment = "center";
			t.color = 0xFF000000
			add(t);
			t = new FlxText(0,t.y+10,FlxG.width,"We always had a passion for games, I tought it would be");
			t.alignment = "center";
			t.color = 0xFF000000
			add(t);
			t = new FlxText(0,t.y+10,FlxG.width,"great to carve those good memories into a game.");
			t.alignment = "center";
			t.color = 0xFF000000
			add(t);
			t = new FlxText(0,t.y+20,FlxG.width,"Thank you for standing beside me, for many years.");
			t.alignment = "center";
			t.color = 0xFF000000
			add(t);
			t = new FlxText(0,t.y+10,FlxG.width,"Baris Bayrak, Cenk Boran, Eren Ozel,");
			t.alignment = "center";
			t.color = 0xFF000000
			add(t);
			t = new FlxText(0,t.y+10,FlxG.width,"Emre Buyukozkan, Gokhan Derala, Harun Sarli");
			t.alignment = "center";
			t.color = 0xFF000000
			add(t);
			t = new FlxText(0,t.y+20,FlxG.width,"I wish you a happy new year and one more great decade.");
			t.alignment = "center";
			t.color = 0xFF000000
			add(t);
			t = new FlxText(0,t.y+20,FlxG.width,"This game is still in on development. Please report");
			t.alignment = "center";
			t.color = 0xFF000000
			add(t);
			t = new FlxText(0,t.y+10,FlxG.width,"bugs&requests to godstroke@gmail.com");
			t.alignment = "center";
			t.color = 0xFF000000
			add(t);
			
			t = new FlxText(0,FlxG.height-20,FlxG.width,"click to play (have fun)");
			//t = new FlxText(0,FlxG.height-20,FlxG.width,"click to play (WASD keys to move)");
			t.alignment = "center";
			t.color = 0xFF000000
			add(t);
			
			//walls
			west_wall = new FlxSprite(0,0);
			west_wall.createGraphic(1,FlxG.height,0xFF000000);
			walls.push(west_wall);
			add(west_wall);
			
			north_wall = new FlxSprite(0,0);
			north_wall.createGraphic(FlxG.width,1,0xFF000000);
			walls.push(north_wall);
			add(north_wall); 
			
			east_wall = new FlxSprite(FlxG.width-1,0);
			east_wall.createGraphic(1,FlxG.height,0xFF000000);
			walls.push(east_wall);
			add(east_wall); 
			
			south_wall = new FlxSprite(0,FlxG.height-1);
			south_wall.createGraphic(FlxG.width,1,0xFF000000);
			walls.push(south_wall);
			add(south_wall); 
			
			
		}

		override public function update():void
		{
			///*delete this on deploy*/FlxG.switchState(PlayState);
			
			super.update();
			if(FlxG.mouse.justPressed())
				FlxG.switchState(PlayState);
		}
	}
}
