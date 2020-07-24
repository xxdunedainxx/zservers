# aws s3 mb s3://zkube.zee-aws.net
# export KOPS_STATE_STORE=s3://zkube.zee-aws.net
# 
kops create cluster \
--zones=us-west-2a \
--dns-zone zkube-cluster.zee-aws.net \
--cloud aws \
--name zkube-cluster.zee-aws.net \
--ssh-public-key ~/zkops.pub \
--target terraform \
--out . 
# kops get cluster
# kubectl config current-context
# remember ~/.kube/config