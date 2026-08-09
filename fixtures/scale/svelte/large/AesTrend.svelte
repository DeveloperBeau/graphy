<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForAes(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="aes-trend">
  <TrendSparkline />
  <p>{trendForAes(rows)}</p>
</div>

<style>
  .aes-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
