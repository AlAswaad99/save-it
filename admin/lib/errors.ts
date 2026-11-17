/** Maps an `SIxxx` RPC code to the admin message. Specific codes land with the RPCs. */
export function messageForCode(code: string): string {
  return `Something went wrong (${code}).`;
}
