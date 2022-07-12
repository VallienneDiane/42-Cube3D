# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dvallien <dvallien@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/05/30 13:51:16 by dvallien          #+#    #+#              #
#    Updated: 2022/07/12 11:45:08 by dvallien         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME := cub3D
LIB := ./libft/libft.a

LIBMLX = ./mlx/libmlx.a ./mlx_2/libmlx.dylib

DIR_SRCS := ./SRCS
LST_SRCS := main.c					\
			parse_map.c 			\
			parse_file.c			\
			build_map.c				\
			get_params.c 			\
			game.c					\
			init_struct.c			\
			init_texture.c			\
			moves.c					\
			acceleration.c			\
			collision.c				\
			raycasting.c 			\
			key_hook.c				\
			dist_to_wall.c			\
			dist_to_wall_utils.c	\
			render_img.c			\
			render_wall.c 			\
			render_sky.c 			\
			render_floor.c 			\
			minimap.c 				\
			color.c 				\
			error.c 				\
			utils.c 				\
			
			
DIR_OBJS := ./.OBJS
LST_OBJS := $(LST_SRCS:.c=.o)

SRCS := $(addprefix $(DIR_SRCS)/, $(LST_SRCS))
OBJS := $(addprefix $(DIR_OBJS)/, $(LST_OBJS))
INCLUDE := ./INCLUDES/cub.h

CC := gcc
CFLAGS := -Wall -Wextra -Werror -O3


$(DIR_OBJS)/%.o : $(DIR_SRCS)/%.c $(INCLUDE) Makefile
		@mkdir -p $(DIR_OBJS)
		$(CC) $(CFLAGS) -Imlx -I $(INCLUDE) -c $< -o $@

all : libft minilibx $(NAME)
		@printf "\033[0;32mProject is ready to run !\033[0m\n"

libft :
		@make -C ./libft

minilibx:
		@make -C ./mlx
		@make -C ./mlx_2

$(NAME) : $(OBJS) $(LIBMLX) $(LIB) Makefile
		@cp mlx_2/libmlx.dylib .
		$(CC) $(OBJS) $(LIB) $(LIBMLX) -Lmlx -lmlx -framework OpenGL -framework AppKit -o $(NAME)
		@printf "\033[0;32mCompilation has succeeded !\033[0m\n"

DIR_OBJS :
		mkdir -p $(DIR_OBJS)

clean:
		@rm -rf $(DIR_OBJS)
		@make clean -C ./libft
		@make clean -C ./mlx
		@make clean -C ./mlx_2
		@printf "\033[0;33mCube3D's objects deleted\033[0m\n"

fclean:	clean
		@rm -rf $(NAME)
		@rm -rf $(LIB)
		@rm -rf $(LIBMLX)
		@rm -rf $(LIBMLX2)
		@rm -rf ./libmlx.dylib
		@printf "\033[0;33m$(LIB) deleted\033[0m\n"
		@printf "\033[0;33m$(LIBMLX) deleted\033[0m\n"
		@printf "\033[0;33m$(LIBMLX2) deleted\033[0m\n"
		@printf "\033[0;33m./$(NAME) deleted\033[0m\n"

re:		fclean all

norme :
		@printf "\033[36mNorminette :\033[0m\n"
		norminette $(SRCS) $(INCLUDE) ./libft

.PHONY:	all clean fclean re minilibx libft