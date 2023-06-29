echo "UUID GPU List - target"
nvidia-smi -L

python train.py --dataroot ../dataset/data_230629 --name data_230629 --CUT_mode CUT --load_size 500 --crop_size 500 --n_epochs 100 --n_epochs_decay 100 --gpu_ids 0
