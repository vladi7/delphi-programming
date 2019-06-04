
namespace MGML_MATH
{	
 template <class T>
 inline T SIGN(T num)  { return (num > (T)0) ? (T)1 : (T)-1; } 
};	


	template<class Trace_Specific>
	bool Bresencham3D(const VECTOR<3,int>& p1,const VECTOR<3,int>& p2,Trace_Specific* pTss)		
	{
		typedef Trace_Specific TS;

		int x = p1.x;
		int y = p1.y;
		int z = p1.z;

	//	if(x < 0) x  =  0;
	//	if(y < 0) y  =  0;
	//	if(z < 0) z  =  0;
  
		int dx = abs(p2.x-x);
		int dy = abs(p2.y-y);
		int dz = abs(p2.z-z);

		int sx = MGML_MATH::SIGN(p2.x-x);
		int sy = MGML_MATH::SIGN(p2.y-y);
		int sz = MGML_MATH::SIGN(p2.z-z);

		if( (dy>=dx) && (dy>=dz) )
		{
			register int e_yx = (dx-dy) << 1;
			register int e_yz = (dz-dy) << 1;

			e_yx -= (e_yx >> 1);
			e_yz -= (e_yz >> 1);
			
			for(register int i=0;i<dy;i++)
			{
				if(trace_in_voxel<TS>(x,y,z,pTss)) 
					return true;
				if(e_yx>=0)
				{	
					x += sx;
					e_yx -= (dy << 1);
					if(trace_in_voxel<TS>(x,y,z,pTss)) 
						return true;
				}

				if(e_yz>=0)
				{	
					z += sz;
					e_yz -= (dy << 1);
					if(trace_in_voxel<TS>(x,y,z,pTss)) 
						return true;  
				}

				y += sy;
				e_yx += (dx << 1);
				e_yz += (dz << 1);
			}
		}
		else if( (dx>=dy) && (dx>=dz) )
		{
			register int e_xy = (dy-dx) << 1;
			register int e_xz = (dz-dx) << 1;

			e_xz -= (e_xz >> 1); 
			e_xy -= (e_xy >> 1); 
			
			for(register int i=0;i<dx;i++)
			{
				if(trace_in_voxel<TS>(x,y,z,pTss)) 
					return true;
		
				if(e_xy>=0)
				{
					y += sy;
					e_xy -= (dx << 1);
					if(trace_in_voxel<TS>(x,y,z,pTss)) 
						return true;
				}

				if(e_xz>=0)
				{
					z += sz;
					e_xz -= (dx << 1);
					if(trace_in_voxel<TS>(x,y,z,pTss)) 
						return true; 
				}
				x += sx;
				e_xy +=(dy << 1);
				e_xz +=(dz << 1);
			}  
		}
		else // (dz>=dy) && (dz>=dx)
		{
			register int e_zx = (dx-dz) << 1;
			register int e_zy = (dy-dz) << 1;

			e_zx -= (e_zx >> 1);
			e_zy -= (e_zy >> 1);
			
			for(register int i=0;i<dz;i++)
			{
				if(trace_in_voxel<TS>(x,y,z,pTss)) 
					return true;
				if(e_zx>=0)
				{
					x += sx;
					e_zx -= (dz << 1);
					if(trace_in_voxel<TS>(x,y,z,pTss)) 
						return true;
				}
				if(e_zy>=0)
				{
					y += sy;
					e_zy -= (dz << 1);
					if(trace_in_voxel<TS>(x,y,z,pTss)) 
						return true;
				}

				z += sz;
				e_zx +=(dx << 1);
				e_zy +=(dy << 1);
			}  


		}

		if(trace_in_voxel<TS>(x,y,z,pTss)) 
			return true;
		return false;
	}