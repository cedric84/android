/**
 * @brief		The application entry point.
 * @file
 */

#include <stdlib.h>
#include <stdio.h>

/**
 * @brief		The application entry point.
 * @param		[in]	argc	The number of arguments.
 * @param		[in]	argv	The arguments values.
 * @return		Returns EXIT_SUCCESS on success.
 */
extern int
main(int argc, char* argv[])
{
	printf("%s started\n", __func__);
	printf("%s terminated\n", __func__);
	return EXIT_SUCCESS;
}
