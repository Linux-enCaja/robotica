/* Internet Protocol services */

// $Id: inet.h 3136 2011-10-13 07:43:37Z svn $

#include <sys/param.h>

// Network protocol macros

#define	AF_INET			2
#define AF_INET6		10

// Network byte order macros

#if BYTE_ORDER == BIG_ENDIAN
#define htonl(x)	(x)
#define ntohl(x)	(x)
#define htons(x)	(x)
#define ntohs(x)	(x)
#elif BYTE_ORDER == LITTLE_ENDIAN
#define htonl(x)	__bswap_32(x)
#define ntohl(x)	__bswap_32(x)
#define htons(x)	(((x << 8) & 0xff00) | ((x >> 8) & 0x00ff))
#define ntohs(x)	(((x << 8) & 0xff00) | ((x >> 8) & 0x00ff))
#else
#error "Unsupported byte order!"
#endif

#define INET_ADDRSTRLEN		16
#define INET6_ADDRSTRLEN	46

char *inet_ntop(int af, const void *src, char *dst, int size);

int inet_pton(int af, const char *src, void *dst);
