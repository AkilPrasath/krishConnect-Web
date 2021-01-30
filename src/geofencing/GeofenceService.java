package geofencing;

import javax.print.attribute.standard.DateTimeAtCompleted;

public class GeofenceService {
	private static String[] BlockNames = { "C2 Block", "C5 Block", "Mech Block", "Admin Block", "Food court",
			"Convention center"

	};
	private static Position[][] positionMatrix = { 
			{ new Position(10.937011, 76.956221), 
				new Position(10.937099, 76.956213),
			new Position(10.937101, 76.956124), 
			new Position(10.937371, 76.956113), 
			new Position(10.937381, 76.956203),
			new Position(10.937463, 76.956202),
			new Position(10.937466, 76.956296), 
			new Position(10.937383, 76.956302),
			new Position(10.937380, 76.956398),
			new Position(10.937107, 76.956416), 
			new Position(10.937107, 76.956316),
			new Position(10.937011, 76.956322), 
			new Position(10.937011, 76.956221),
			},
			{ new Position(10.937441, 76.955152), 
				new Position(10.937441, 76.955319),
					new Position(10.937295, 76.955525),
					new Position(10.937042, 76.955539),
					new Position(10.937029, 76.955329), 
					new Position(10.937290, 76.955313),
					new Position(10.937284, 76.955163), 
					new Position(10.937441, 76.955152), 
					},
			{ new Position(10.93613, 76.95570),
						new Position(10.93614, 76.95637), 
						new Position(10.93599, 76.95573),
					new Position(10.93601, 76.95636), 
					new Position(10.93613, 76.95570), },
			{ new Position(10.937974, 76.956134), 
						new Position(10.937953, 76.956273),
					new Position(10.937822, 76.956373),
					new Position(10.937666, 76.956581),
					new Position(10.937632, 76.956345), 
					new Position(10.937863, 76.956134),
					new Position(10.937974, 76.956134), 
					},
			{ new Position(10.938752, 76.956429), 
						new Position(10.938964, 76.956421),
					new Position(10.938976, 76.956830),
					new Position(10.938764, 76.956843),
					new Position(10.938752, 76.956429), },
			{ new Position(10.938558, 76.956581),
						new Position(10.938554, 76.956771),
					new Position(10.938278, 76.956797), 
					new Position(10.938273, 76.956599),
					new Position(10.938558, 76.956581),
					}, 
			};
	static String findBlock(double lat,double lon) {
		System.out.println("location updating..");
		int blockNameIndex =positionMatrix.length;
		for(int i=0; i<positionMatrix.length; i++) {
			Position[] polygon = positionMatrix[i];
			if(isInsidePolygon(new Position(lat,lon),polygon)) {
				blockNameIndex = i;
				break;
			}
		}
		if(blockNameIndex<positionMatrix.length) {
			return BlockNames[blockNameIndex];
		}
		return "Outside";
		
	}
	public static boolean isInsidePolygon(Position currentPosition, Position[] polygon) {
		 Position lastPoint = polygon[polygon.length - 1];
		    boolean isInside = false;
		    double x = currentPosition.longitude;
		    for (Position point : polygon) {
		      double x1 = lastPoint.longitude;
		      double x2 = point.longitude; 
		      double dx = x2 - x1; 
		      
		      if ( Math.abs(dx) > 180.0) {
		        if (x > 0) { 
		          while (x1 < 0) x1 += 360;
		          while (x2 < 0) x2 += 360;
		        } else {
		          while (x1 > 0) x1 -= 360;
		          while (x2 > 0) x2 -= 360;
		        }
		        dx = x2 - x1;
		      }

		      if ((x1 <= x && x2 > x) || (x1 >= x && x2 < x)) {
		        double grad = (point.latitude - lastPoint.latitude) / dx;
		        double intersectAtLat = lastPoint.latitude + ((x - x1) * grad);

		        if (intersectAtLat > currentPosition.latitude) isInside = !isInside;
		      }
		      lastPoint = point;
		    }

		    return isInside;
	}

}


 
