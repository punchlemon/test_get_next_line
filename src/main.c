/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: retanaka <retanaka@student.42.tokyo>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/14 14:49:30 by retanaka          #+#    #+#             */
/*   Updated: 2024/05/27 19:19:15 by retanaka         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "test.h"
#include "get_next_line.h"

void	put_num(int i)
{
	char	c;

	c = i + '0';
	write(1, &c, 1);
}

ssize_t	ft_strlen(char *s)
{
	ssize_t	i;

	if (s == NULL)
		return (0);
	i = 0;
	while (s[i])
		i++;
	return (i);
}

int	main(void)
{
	int		fd;
	char	*s;
	size_t	i;

	fd = open("files/test1.txt", O_RDONLY);
	i = 0;
	while (1)
	{
		s = get_next_line(-1);
		printf("[%zu]\n", i);
		printf("%s\n", s);
		if (s == NULL)
			break ;
		i++;
	}
	close(fd);
	return (0);
}
