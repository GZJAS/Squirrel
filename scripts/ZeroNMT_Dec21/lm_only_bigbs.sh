gpus=${1:-2}
jbname=${2:-ZeroNMT2}
mode=${3:-train}
load_from=${4:-none}  # --load_from name --resume
seed=${5:-19920206}
port=${6:-22221}

python -m torch.distributed.launch --nproc_per_node=${gpus} --master_port=${port} \
                ez_run.py \
                --prefix 'LM' \
                --mode ${mode} \
                --data_prefix "/private/home/jgu/data/Europarl/" \
                --dataset "es-fr-eval" \
                --src "es,en,fr,en" --trg "en,es,en,fr" \
                --test_src "fr,es,es"  --test_trg "es,fr,en" \
                --train_set "train.bpe.shuf" \
                --dev_set   "dev.bpe"   \
                --test_set  "test.bpe"  \
                --vocab_file "vocab.es-fr-eval.s.w.pt" \
                --load_lazy \
                --base "bpe" \
                --workspace_prefix "/private/home/jgu/space/${jbname}/" \
                --params "t2t-base" \
                --lm_steps 300000 \
                --maximum_steps 300000 \
                --eval_every 500  \
                --save_every 5000 \
                --batch_size 1500 \
                --inter_size 4 \
                --label_smooth 0.1 \
                --drop_ratio 0.1 \
                --lr 0.0005 \
                --weight_decay 0.0001 \
                --share_embeddings \
                --tensorboard \
                --cross_attn_fashion "last_layer" \
                --model 'Transformer' \
                --lang_as_init_token \
                --load_from ${load_from} --resume \
                --seed ${seed} \
                --no_valid --valid_ppl

