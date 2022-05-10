function [x,y] = InvConversion (col,row,matrix,QP)
	bhma0 = 4;
	blockSize0 = 3;
	for i = 1:bhma0:col
		for j = 1:bhma0:row
			frameInvQUANT(i:i+blockSize0 , j:j+blockSize0) = inv_quantization(matrix(i:i+blockSize0 , j:j+blockSize0),QP);
			frameInvDCT(i:i+blockSize0 , j:j+blockSize0) = inv_integer_transform(frameInvQUANT(i:i+blockSize0 , j:j+blockSize0));
		end
	end
	x = frameInvQUANT;
	y = frameInvDCT;
end