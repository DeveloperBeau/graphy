<script>
  import UnitRow from './UnitRow.svelte';

  export let state = [];

  function convertValue(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="unit-converter">
  <UnitRow />
  <p>{convertValue(state)}</p>
</div>

<style>
  .unit-converter {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
