<script>
  export let width = 80;

  function describeWidth() {
    return width + ' columns';
  }
</script>

<label class="width-slider">
  <input type="range" min="40" max="160" bind:value={width} />
  <span>{describeWidth()}</span>
</label>

<style>
  .width-slider {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
  }
</style>
