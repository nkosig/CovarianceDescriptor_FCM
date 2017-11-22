Powerline insulator defect classification using Covariance Descriptor &amp; improved FCM

Function descrptions 

W - image width
H - image height
d - number of features from the image

featureimage = FeatureImage(RGBimage)
- RGBimage (W x H)
- featureimage (W x H x d)

pvector = TensorIntImage(featureimage)
- pvector (1 x d) resulting in W x H x d output

qmatrix = Tensor2ndOIntImage(featureimage)
- qmatrix (d x d) resulting in W x H x d x d output

covmatrix = CovarianceDescrpt(pvector,qmatrix)
- covmatrix (d x d)