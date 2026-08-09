<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForRc4(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="rc4-trend">
  <TrendSparkline />
  <p>{trendForRc4(rows)}</p>
</div>

<style>
  .rc4-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
