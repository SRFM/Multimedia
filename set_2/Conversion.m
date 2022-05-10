function [a,b] = Conversion (col,row,matrix,QP)
	bhma0 = 4;
	blockSize0 = 3;
	for i = 1:bhma0:col
		for j = 1:bhma0:row
			frameDCT(i:i+blockSize0 , j:j+blockSize0) = integer_transform(matrix(i:i+blockSize0 , j:j+blockSize0));
			frameQUANT(i:i+blockSize0 , j:j+blockSize0) = quantization(frameDCT(i:i+blockSize0 , j:j+blockSize0),QP);
		end
	end
	a = frameDCT;
	b = frameQUANT;
end