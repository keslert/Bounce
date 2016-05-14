package  {
	import flash.geom.Point;
	
	public class PaddleCollisionHandler {
		private var v1:Vector2;
		private var v2:Vector2;
		private var v3:Vector2;
		private var v4:Vector2;
		private var v5:Vector2;
		private var p1:Vector2;
		private var paddle:Paddle;
		
		private var maxV:Number;
		public function PaddleCollisionHandler() {
			v1 = new Vector2();
			v2 = new Vector2();
			v3 = new Vector2();
			v4 = new Vector2();
			v5 = new Vector2();
			p1 = new Vector2();
			
			maxV = 8;
		}
		
		function runCheck(ob:Ball,p:Paddle) {
			//calculate new line vector
			paddle = p;
			v1.p0.x = p.p0.x;
			v1.p0.y = p.p0.y;
			v1.p1.x = p.p1.x;
			v1.p1.y = p.p1.y;
			v1 = updateVector(v1, true);
			
			//add air resistance
			ob.vx *= .999;
			ob.vy *= .99;
			//update the vector parameters
			if (ob.vx>maxV)
			{
				ob.vx = maxV;
			}
			else if (ob.vx<-maxV)
			{
				ob.vx = -maxV;
			}
			if (ob.vy>maxV)
			{
				ob.vy = maxV;
			}
			else if (ob.vy<-maxV)
			{
				ob.vy = -maxV;
			}
			//updateObject(ob);
			
			//check the walls for collisions
			v2 = findIntersection(ob, v1);
			v2 = updateVector(v2, false);
			var pen = ob.radius-v2.len;
			//if we have hit the wall
			if (pen>=0)
			{
				//move object away from the wall
				ob.p1.x += v2.dx*pen;
				ob.p1.y += v2.dy*pen;
				//change movement, bounce off from the normal of v
				v3.dx = v2.lx;
				v3.dy = v2.ly;
				v3.lx = v2.dx;
				v3.ly = v2.dy;
				v3.b = 1;
				v3.f = 1;
				v4 = bounce(ob, v3);
				ob.vx = v4.vx;
				ob.vy = v4.vy;
			}
			//make end point equal to starting point for next cycle
			ob.p0 = ob.p1;
			//save the movement without time
		}
		//function to find all parameters for the vector
		function updateVector(v, frompoints)
		{
			//x and y components
			if (frompoints)
			{
				v.vx = v.p1.x-v.p0.x;
				v.vy = v.p1.y-v.p0.y;
			}
			else
			{
				v.p1.x = v.p0.x+v.vx;
				v.p1.y = v.p0.y+v.vy;
			}
			//length of vector
			v.len = Math.sqrt(v.vx*v.vx+v.vy*v.vy);
			//normalized unti-sized components
			if (v.len>0)
			{
				v.dx = v.vx/v.len;
				v.dy = v.vy/v.len;
			}
			else
			{
				v.dx = 0;
				v.dy = 0;
			}
			//right hand normal
			v.rx = -v.dy;
			v.ry = v.dx;
			//left hand normal
			v.lx = v.dy;
			v.ly = -v.dx;
			return v;
		}
		//find intersection point of 2 vectors
		function findIntersection(v1, v2)
		{
			//vector between center of ball and starting point of wall
			v3.vx = v1.p1.x-v2.p0.x;
			v3.vy = v1.p1.y-v2.p0.y;
			//check if we have hit starting point
			var dp = v3.vx*v2.dx+v3.vy*v2.dy;
			if (dp<0)
			{
				//hits starting point
				var v = v3;
			}
			else
			{
				v4.vx = v1.p1.x-v2.p1.x;
				v4.vy = v1.p1.y-v2.p1.y;
				//check if we have hit side or endpoint
				var dp = v4.vx*v2.dx+v4.vy*v2.dy;
				if (dp>0)
				{
					//hits ending point
					var v = v4;
				}
				else
				{
					//it hits the wall
					//project this vector on the normal of the wall
					var v = projectVector(v3, v2.lx, v2.ly);
				}
			}
			return v;
		}
		//find new vector bouncing from v2
		function bounce(v1, v2)
		{
			//projection of v1 on v2
			var proj1 = projectVector(v1, v2.dx, v2.dy);
			//projection of v1 on v2 normal
			var proj2 = projectVector(v1, v2.lx, v2.ly);
			
			//reverse projection on v2 normal
			proj2.len = Math.sqrt(proj2.vx*proj2.vx+proj2.vy*proj2.vy);
			proj2.vx = v2.lx*proj2.len;
			proj2.vy = v2.ly*proj2.len;
			//add the projections
			p1.vx = v1.f*v2.f*proj1.vx+v1.b*v2.b*proj2.vx;
			p1.vy = v1.f*v2.f*proj1.vy+v1.b*v2.b*proj2.vy;
			if(p1.vy > 0) {
				p1.vy = -p1.vy;
				v1.y-=v1.radius;
			}
			p1.vy -= 5;
			paddle.color = v1.color;
			GLOBAL.music.startSound("bounce");
			GLOBAL.engine.ballBounced();
			return p1;
		}
		//project vector v1 on unit-sized vector dx/dy
		function projectVector(v1, dx, dy)
		{
			//find dot product
			var dp = v1.vx*dx+v1.vy*dy;
			
			var proj = new Vector2();
			proj.vx = dp*dx;
			proj.vy = dp*dy;
			return proj;
		}
	}
}
