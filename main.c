/**
 * @brief		The application entry point.
 * @file
 */

#include <stdlib.h>
#include <stdio.h>
#include <android/api-level.h>

/**
 * @brief		The application entry point.
 * @param		[in]	argc	The number of arguments.
 * @param		[in]	argv	The arguments values.
 * @return		Returns EXIT_SUCCESS on success.
 */
extern int
main(int argc, char* argv[])
{
	printf("%s started (API #%d)\n", __func__, __ANDROID_API__);
	printf("%s terminated\n", __func__);
	return (16 == __ANDROID_API__) ? EXIT_FAILURE : EXIT_SUCCESS;
}
