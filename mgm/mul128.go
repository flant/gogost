// GoGOST -- Pure Go GOST cryptographic functions library
// Copyright (C) 2015-2021 Sergey Matveev <stargrave@stargrave.org>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, version 3 of the License.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

package mgm

import (
	"math/big"
)

const Mul128MaxBit = 128 - 1

var R128 = big.NewInt(0).SetBytes([]byte{
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87,
})

type mul128 struct {
	x   *big.Int
	y   *big.Int
	z   *big.Int
	buf [16]byte
}

func newMul128() *mul128 {
	return &mul128{
		x: big.NewInt(0),
		y: big.NewInt(0),
		z: big.NewInt(0),
	}
}

func (mul *mul128) Mul(x, y []byte) []byte {
	mul.x.SetBytes(x)
	mul.y.SetBytes(y)
	mul.z.SetInt64(0)
	for mul.y.BitLen() != 0 {
		if mul.y.Bit(0) == 1 {
			mul.z.Xor(mul.z, mul.x)
		}
		if mul.x.Bit(Mul128MaxBit) == 1 {
			mul.x.SetBit(mul.x, Mul128MaxBit, 0)
			mul.x.Lsh(mul.x, 1)
			mul.x.Xor(mul.x, R128)
		} else {
			mul.x.Lsh(mul.x, 1)
		}
		mul.y.Rsh(mul.y, 1)
	}
	zBytes := mul.z.Bytes()
	rem := len(x) - len(zBytes)
	for i := 0; i < rem; i++ {
		mul.buf[i] = 0
	}
	copy(mul.buf[rem:], zBytes)
	return mul.buf[:]
}
