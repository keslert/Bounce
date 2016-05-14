package  {
	import flash.geom.Point;
	public class BallCollisionHandler {
		private var g_vc:Vector2;
		private var v3:Vector2;
		private var g_vn:Vector2;
		private var v4:Vector2;
		private var vc:Vector2;
		private var totalRadius:Number;
		private var p2:Point;
		private var p3:Point;
		private var stageW:Number;
		public function BallCollisionHandler() {
			g_vc = new Vector2();
			v3 = new Vector2();
			g_vn = new Vector2();
			v4 = new Vector2();
			vc = new Vector2();
			p2 = new Point(0,0);
			p3 = new Point(0,0);
			stageW = 480;
		}
		//create game object
		function drawAll(balls:Array){
			var l = balls.length;
			var ball:Ball;
			for(var i=0;i<l;i++){
				ball = balls[i];
				//place ball mc
				ball.x=ball.p1.x;
				ball.y=ball.p1.y;
				ball.p0=ball.p1;
				updateVector2(ball,false);
			}
		}
		//main function
		public function runCheckBalls(balls:Array){
			var l = balls.length;
			var ob:Ball;
			var ob2:Ball;
			for(var i:int=0; i<l; i++){
				ob=balls[i];
				updateVector2(ob,false);
				for(var j:int=0; j<l;j++){
					if(i==j)continue;
					
					ob2=balls[j];
					//vector between center points of ball
					
					g_vc.p0 = ob.p0;
					g_vc.p1 = ob2.p0;
					updateVector2(g_vc, true);
					//sum of radius
					totalRadius=ob.radius+ob2.radius;
					var pen=totalRadius-g_vc.len;
					//check if balls collide at start
					/*
					if(pen>=0){
						//move object away from the ball
						ob.p1.x-=g_vc.dx*pen;
						ob.p1.y-=g_vc.dy*pen;
						//change movement, bounce off from the normal of v
						var newv=bounceBalls(ob, ob2, g_vc);
						ob.vx=newv[0].vx;
						ob.vy=newv[0].vy;
						ob2.vx=newv[1].vx;
						ob2.vy=newv[1].vy;
					}
					
					else{
						//reduce movement vector from ball2 from movement vector of ball1
						
						v3.p0=ob.p0;
						v3.vx=ob.vx-ob2.vx;
						v3.vy=ob.vy-ob2.vy;
						updateVector2(v3,false);
						//use v3 as new movement vector for collision calculation
						//projection of vc on v3
						var vp:Projection=projectVector2(g_vc, v3.dx, v3.dy);
						//vector to center of ball2 in direction of movement vectors normal
						
						p2.x = ob.p0.x+vp.vx;
						p2.y = ob.p0.y+vp.vy;
						g_vn.p0=p2;
						g_vn.p1=ob2.p0;
						updateVector2(g_vn, true);
						//check if vn is shorter then combined radiuses
						var diff=totalRadius-g_vn.len;
						var collision=false;
						if(diff>0){
							//collision
							//amount to move back moving ball
							var moveBack=Math.sqrt(totalRadius*totalRadius-g_vn.len*g_vn.len);
							
							p3.x = g_vn.p0.x-moveBack*v3.dx;
							p3.y = g_vn.p0.y-moveBack*v3.dy;
							//vector from ball1 starting point to its coordinates when collision happens
							
							v4.p0 = ob.p0;
							v4.p1 = p3;
							updateVector2(v4, true);
							//check if p3 is on the movement vector
							if(v4.len<=v3.len && dotP(v4, ob)>0){
								//collision
								var t=v4.len/v3.len;
								collision=true;
								
								ob.p1.x = ob.p0.x+t*ob.vx;
								ob.p1.y = ob.p0.y+t*ob.vy;
								
								ob2.p1.x = ob2.p0.x+t*ob2.vx;
								ob2.p1.y = ob2.p0.y+t*ob2.vy;
								//vector between centers of ball in the moment of collision
								var vc={p0:ob.p1, p1:ob2.p1};
								vc.p0 = ob.p1;
								vc.p1 = ob2.p1;
								updateVector2(vc, true);
								var newv=bounceBalls(ob, ob2, vc);
								ob.vx=newv[0].vx;
								ob.vy=newv[0].vy;
								ob2.vx=newv[1].vx;
								ob2.vy=newv[1].vy;
								makeVector2(ob2);
								makeVector2(ob);
							}
						}
					}*/
				}
			}
			//draw it
			drawAll(balls);
		}
		//function to find all parameters for the vector
		function updateVector2(v, frompoints){
			//x and y components
			if(frompoints==true){
				v.vx=v.p1.x-v.p0.x;
				v.vy=v.p1.y-v.p0.y;
			}else{
				v.p1.x=v.p0.x+v.vx;
				v.p1.y=v.p0.y+v.vy;
			}
			//reset object to other side if gone out of stage
			holdVector2(v);
			makeVector2(v);
		}
		function makeVector2(v){
			//length of vector
			v.len=Math.sqrt(v.vx*v.vx+v.vy*v.vy);
			//normalized unti-sized components
			if(v.len>0){
				v.dx=v.vx/v.len;
				v.dy=v.vy/v.len;
			}else{
				v.dx=0;
				v.dy=0;
			}
			//right hand normal
			v.rx = -v.dy;
			v.ry = v.dx;
			//left hand normal
			v.lx = v.dy;
			v.ly = -v.dx;
		}
		//function to hold balls inside stage
		function holdVector2(v){
			//reset object to other side if gone out of stage
			if(v.p1.x>stageW-v.radius){
				v.p1.x=stageW-v.radius;
				v.vx=-Math.abs(v.vx);
			}else if(v.p1.x<v.radius){
				v.p1.x=v.radius;
				v.vx=Math.abs(v.vx);
			}
		}
		//calculate dot product of 2 vectors
		function dotP(v1, v2){
			var dp = v1.vx*v2.vx + v1.vy*v2.vy;
			return dp;
		}
		//project vector v1 on unit-sized vector dx/dy
		function projectVector2(v1, dx, dy){
			//find dot product
			var dp = v1.vx*dx + v1.vy*dy;
			return new Projection(dp*dx,dp*dy);
		}
		//find new movement vector bouncing from v
		function bounceBalls(v1, v2, v){
			//projection of v1 on v
			var proj11=projectVector2(v1, v.dx, v.dy);
			//projection of v1 on v normal
			var proj12=projectVector2(v1, v.lx, v.ly);
			//projection of v2 on v
			var proj21=projectVector2(v2, v.dx, v.dy);
			//projection of v2 on v normal
			var proj22=projectVector2(v2, v.lx, v.ly);
		
			var P:Number=v1.m*proj11.vx+v2.m*proj21.vx;
			var V:Number=proj11.vx-proj21.vx;
			var v2fx:Number=(P+V*v1.m)/(v1.m+v2.m);
			var v1fx:Number=v2fx-V;
		
			P=v1.m*proj11.vy+v2.m*proj21.vy;
			V=proj11.vy-proj21.vy;
			var v2fy=(P+V*v1.m)/(v1.m+v2.m);
			var v1fy=v2fy-V;
			GLOBAL.music.startSound("collide");
			// new proj		
			return [new Projection(proj12.vx+v1fx,proj12.vy+v1fy),
					new Projection(proj22.vx+v2fx,proj22.vy+v2fy)];
		}
		
	}
}
