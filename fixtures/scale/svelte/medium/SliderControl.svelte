<script>
  export let state = [];

  function sliderValue(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="slider-control">
  <p>{sliderValue(state)}</p>
</div>

<style>
  .slider-control {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
