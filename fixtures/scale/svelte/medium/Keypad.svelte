<script>
  import DigitKey from './DigitKey.svelte';
  import OperatorKey from './OperatorKey.svelte';
  import FunctionKey from './FunctionKey.svelte';
  import MemoryKey from './MemoryKey.svelte';
  import ClearKey from './ClearKey.svelte';
  import EqualsKey from './EqualsKey.svelte';

  export let state = [];

  function layoutKeys(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="keypad">
  <DigitKey />
  <OperatorKey />
  <FunctionKey />
  <MemoryKey />
  <ClearKey />
  <EqualsKey />
  <p>{layoutKeys(state)}</p>
</div>

<style>
  .keypad {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
