#!/bin/bash

deepspeed --include localhost:0,1,2,3 \
    ~/yule-tx/RL4VLM/LLaVA/llava/train/train_mem.py \
    --deepspeed ~/yule-tx/RL4VLM/VLM_PPO/scripts/zero3.json \
    --model_name_or_path ~/yule-tx/models/llava-v1.6-mistral-7b \
    --version v1 \
    --data_path ~/yule-tx/sft-data/numberline/numberline.json \
    --image_folder ~/yule-tx/sft-data/numberline/numberline_data_folder \
    --vision_tower openai/clip-vit-large-patch14-336 \
    --mm_projector_type mlp2x_gelu \
    --mm_vision_select_layer -2 \
    --mm_use_im_start_end False \
    --mm_use_im_patch_token False \
    --image_aspect_ratio pad \
    --group_by_modality_length True \
    --bf16 True \
    --output_dir ~/yule-tx/models/llava-v1.6-mistral-7b-nl-sft \
    --num_train_epochs 1 \
    --per_device_train_batch_size 16 \
    --per_device_eval_batch_size 4 \
    --gradient_accumulation_steps 1 \
    --evaluation_strategy "no" \
    --save_strategy "steps" \
    --save_steps 50000 \
    --save_total_limit 1 \
    --learning_rate 2e-5 \
    --weight_decay 0. \
    --warmup_ratio 0.03 \
    --lr_scheduler_type "cosine" \
    --logging_steps 1 \
    --tf32 True \
    --model_max_length 2048 \
    --gradient_checkpointing True \
    --dataloader_num_workers 4 \
    --lazy_preprocess True \
    # --report_to wandb