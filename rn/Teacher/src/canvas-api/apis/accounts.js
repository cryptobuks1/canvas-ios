//
// Copyright (C) 2016-present Instructure, Inc.
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
//

/* @flow */

import httpClient from '../httpClient'
import { paginate, exhaust } from '../utils/pagination'

// Only admins can hit this api successfully. Otherwise, will send back a 401
export function account (): Promise<ApiResponse<Account>> {
  return httpClient().get('accounts/self')
}

export function roles (accountID: string): Promise<ApiResponse<Role[]>> {
  const roles = paginate(`/accounts/${accountID}/roles`)
  return exhaust(roles)
}