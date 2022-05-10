function [x] = motionVector(SearchRange,col,row,postScale0,frame1)
	blockSize1 = 15
	SADmin = 1e6;
	
    %Splitting frame1 into 16x16
	for i = 1:16:col
		for j = 1:16:row
		
			for x = -SearchRange:SearchRange
   				 for y = -SearchRange:SearchRange
					%limitations for the width of the matrices
					if((x>0)&&((x+blockSize1)<=144))
						if((y>0)&&((y+blockSize1)<=176))
							%motion vector calculation
							dianKin = postScale0(x:x+blockSize1,y:y+blockSize1);
							SAD = sum(sum(abs(frame1(i:i+blockSize1,j:j+blockSize1)-dianKin)));
						
							%minimum SAD check
							if(SAD < SADmin)
								SADmin = SAD;
								motVect(i:i+blockSize1,j:j+blockSize1) = dianKin;
							end
						end
					end
				end
			end
		end
	end
end