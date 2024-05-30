# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: retanaka <retanaka@student.42.tokyo>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/05/14 16:38:27 by retanaka          #+#    #+#              #
#    Updated: 2024/05/30 15:09:12 by retanaka         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME			=	test
INCLUDE			=	include
GNL_DIR			=	../
SRC_DIR			=	src/
OBJ_DIR			=	obj/
CC				=	cc
CFLAGS			=	-Wall -Wextra -Werror
IFLAGS			=	-I$(INCLUDE) -I$(GNL_DIR)
RM				=	rm -f
AR				=	ar rcs
ifdef BUFFER_SIZE
CFLAGS			+=	-DBUFFER_SIZE=$(BUFFER_SIZE)
endif
DFLAGS			=	-g

# Colors
DEF_COLOR		=	\033[0;39m
GRAY			=	\033[0;90m
RED				=	\033[0;91m
GREEN			=	\033[0;92m
YELLOW			=	\033[0;93m
BLUE			=	\033[0;94m
MAGENTA			=	\033[0;95m
CYAN			=	\033[0;96m
WHITE			=	\033[0;97m

SRC_FILES		=	$(notdir $(basename $(wildcard $(SRC_DIR)*.c)))
SRC_FILES		+=	$(notdir $(basename $(wildcard $(GNL_DIR)*.c)))
SRC				=	$(wildcard $(SRC_DIR)*.c)
SRC				=	$(wildcard $(GNL_DIR)*.c)
OBJ				=	$(addprefix $(OBJ_DIR), $(addsuffix .o, $(SRC_FILES)))
OBJ_DIR_FLAG	=	.obj_dir_exists

all:			$(NAME)

$(NAME):		$(OBJ)
				@$(CC) $(CFLAGS) $(IFLAGS) $(OBJ) -o $(NAME) $(DFLAGS)
				@echo "$(GREEN)test compiled!$(DEF_COLOR)"

$(OBJ_DIR)%.o:	$(GNL_DIR)%.c | $(OBJ_DIR_FLAG)
				@echo "$(YELLOW)Compiling: $< $(DEF_COLOR)"
				@$(CC) $(CFLAGS) -I$(GNL_DIR) -c $< -o $@ $(DFLAGS)

$(OBJ_DIR)%.o:	$(SRC_DIR)%.c | $(OBJ_DIR_FLAG)
				@echo "$(YELLOW)Compiling: $< $(DEF_COLOR)"
				@$(CC) $(CFLAGS) $(IFLAGS) -c $< -o $@ $(DFLAGS)

$(OBJ_DIR_FLAG):
				@mkdir -p $(OBJ_DIR)

clean:
				@$(RM) -r $(OBJ_DIR)
				@echo "$(BLUE)Object files cleaned!$(DEF_COLOR)"

fclean:			clean
				@$(RM) $(NAME)
				@echo "$(CYAN)Executable files cleaned!$(DEF_COLOR)"

re:				fclean all
				@echo "$(CYAN)Cleaned and rebuilt everything for test!$(DEF_COLOR)"

norm:
				@norminette $(GNL_DIR) | grep -v Norme -B1 || true

.PHONY:			all clean fclean re norm
