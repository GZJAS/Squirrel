mode=${3:-train}
load_from=${4:-none}  # --load_from name --resume
python -m torch.distributed.launch --nproc_per_node=${1} --master_port=23456 \
                ez_run.py \
                --prefix segment \
                --mode ${mode} \
                --data_prefix "/private/home/jgu/data/" \
                --dataset "kftt" \
                --src "en" --trg "ja" \
                --train_set "train.tok" \
                --dev_set   "dev.tok"   \
                --test_set  "test.tok"  \
                --vocab_file "vocab.ja-en.s.c.seg.pt" \
                --load_lazy \
                --base "char" \
                --workspace_prefix "/private/home/jgu/space/${2}/" \
                --params "t2t-base" \
                --eval_every 500  \
                --batch_size 3277 \
                --inter_size 5 \
                --label_smooth 0.1 \
                --share_embeddings \
                --tensorboard \
                --cross_attn_fashion "forward" \
                --load_from ${load_from} 