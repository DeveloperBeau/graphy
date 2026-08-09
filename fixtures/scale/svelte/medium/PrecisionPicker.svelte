<script>
  import SliderControl from './SliderControl.svelte';

  export let state = [];

  function pickPrecision(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="precision-picker">
  <SliderControl />
  <p>{pickPrecision(state)}</p>
</div>

<style>
  .precision-picker {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
