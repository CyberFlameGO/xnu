/*
 * Copyright (c) 2000 Apple Computer, Inc. All rights reserved.
 *
 * @APPLE_LICENSE_OSREFERENCE_HEADER_START@
 * 
 * This file contains Original Code and/or Modifications of Original Code 
 * as defined in and that are subject to the Apple Public Source License 
 * Version 2.0 (the 'License'). You may not use this file except in 
 * compliance with the License.  The rights granted to you under the 
 * License may not be used to create, or enable the creation or 
 * redistribution of, unlawful or unlicensed copies of an Apple operating 
 * system, or to circumvent, violate, or enable the circumvention or 
 * violation of, any terms of an Apple operating system software license 
 * agreement.
 *
 * Please obtain a copy of the License at 
 * http://www.opensource.apple.com/apsl/ and read it before using this 
 * file.
 *
 * The Original Code and all software distributed under the License are 
 * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER 
 * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES, 
 * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY, 
 * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT. 
 * Please see the License for the specific language governing rights and 
 * limitations under the License.
 *
 * @APPLE_LICENSE_OSREFERENCE_HEADER_END@
 */

#;**************************************************************************
#;* Boolean OSCompareAndSwap(SInt32 oldValue, SInt32 newValue, SInt32 * ptr) *
#;**************************************************************************

	.globl _OSCompareAndSwap

_OSCompareAndSwap:
	movl		 4(%esp), %eax	#; oldValue
	movl		 8(%esp), %edx	#; newValue
	movl		12(%esp), %ecx	#; ptr
	lock
	cmpxchgl	%edx, 0(%ecx)	#; CAS (eax is an implicit operand)
	sete		%al				#; did CAS succeed? (TZ=1)
	movzbl		%al, %eax		#; clear out the high bytes
	ret
